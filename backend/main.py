import os
import base64
import json
import re
from fastapi import FastAPI, UploadFile, File, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List
from groq import Groq
from supabase import create_client, Client
from sentence_transformers import SentenceTransformer
from dotenv import load_dotenv

load_dotenv()

# --- INITIALIZATION ---
app = FastAPI(title="Aahar AI Backend", version="1.0")

# Allow Flutter/Web to communicate with this API
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize Clients
groq_client = Groq(api_key=os.getenv("GROQ_API_KEY"))
supabase: Client = create_client(os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY"))
print("🧠 Loading Local Embedding Model...")
embedding_model = SentenceTransformer('all-MiniLM-L6-v2')

# --- PYDANTIC SCHEMAS (To force perfect JSON from AI) ---
class Ingredient(BaseModel):
    name: str
    weight_g: float

class Dish(BaseModel):
    dish_name: str
    bounding_box: List[float] # This strictly enforces [x1, y1, x2, y2]
    gravy_detected: bool
    ingredients: List[Ingredient]

class FoodAnalysis(BaseModel):
    dishes: List[Dish]

# --- HELPER FUNCTIONS ---
def encode_image(file_bytes):
    return base64.b64encode(file_bytes).decode('utf-8')

def match_ingredient_in_db(ingredient_name: str, weight_g: float):
    # Convert name to vector
    query_vector = embedding_model.encode(ingredient_name).tolist()
    
    # Search Supabase (Top 1 match, minimum 40% similarity)
    try:
        response = supabase.rpc(
            'match_ingredients', 
            {'query_embedding': query_vector, 'match_threshold': 0.4, 'match_count': 1}
        ).execute()
        
        matches = response.data
    except Exception as e:
        print(f"Supabase error: {e}")
        matches = []

    if not matches:
        return {"name_db": "Unknown", "calories": 0, "protein": 0, "carbs": 0, "fats": 0, "confidence": 0}
        
    best_match = matches[0]
    multiplier = weight_g / 100.0
    
    return {
        "name_db": best_match['name_en'],
        "calories": round(best_match['calories_per_100g'] * multiplier, 1),
        "protein": round(best_match['protein_per_100g'] * multiplier, 1),
        "carbs": round(best_match['carbs_per_100g'] * multiplier, 1),
        "fats": round(best_match['fats_per_100g'] * multiplier, 1),
        "confidence": round(best_match['similarity'] * 100, 1)
    }

# --- THE MAIN ENDPOINT ---
@app.post("/api/v1/analyze/vision")
async def analyze_vision(file: UploadFile = File(...)):
    print(f"📥 Received file: {file.filename} ({file.content_type})")
    try:
        # 1. Read the image uploaded by the mobile app
        contents = await file.read()
        print(f"📦 Read {len(contents)} bytes from the uploaded file.")
        base64_image = encode_image(contents)
        print("🖼️ Image encoding successful.")
        
        # Determine model
        model_id = os.getenv("GROQ_MODEL", "meta-llama/llama-4-scout-17b-16e-instruct")

        # 2. Ask Groq to analyze the image
        print(f"🚀 Sending to Groq Vision using model: {model_id}...")
        system_prompt = """
        You are an expert Indian Nutritionist and computer vision assistant. 
        Analyze this image of an Indian meal. 
        
        CRITICAL FORMATTING RULES:
        1. Output MUST be valid JSON.
        2. Bounding boxes MUST be a list of 4 individual floats: [y_min, x_min, y_max, x_max].
        3. NEVER merge numbers like "0.1230.456". Every number must be separated by a comma and a space.
        4. NEVER put quotes around the numbers or the list itself.
        5. Return ONLY the JSON object, no other text.

        The structure should follow this schema:
        {
          "dishes": [
            {
              "dish_name": "Name",
              "bounding_box": [0.12, 0.34, 0.56, 0.78], 
              "gravy_detected": true,
              "ingredients": [
                {"name": "Ingredient", "weight_g": 100.0}
              ]
            }
          ]
        }
        """
        
        chat_completion = groq_client.chat.completions.create(
            messages=[
                {"role": "system", "content": system_prompt},
                {
                    "role": "user",
                    "content":[
                        {"type": "text", "text": "Analyze this Indian plate and return JSON. Ensure bounding_box has 4 distinct comma-separated floats."},
                        {"type": "image_url", "image_url": {"url": f"data:image/jpeg;base64,{base64_image}"}}
                    ]
                }
            ],
            model=model_id,
            temperature=0.0
        )
        
        # Parse the raw JSON from Groq
        raw_content = chat_completion.choices[0].message.content
        print(f"DEBUG: AI RAW CONTENT: {raw_content}")
        
        # Pre-process content to fix common LLM formatting issues
        
        # Keep only the JSON object if the model wraps it in text.
        if "{" in raw_content and "}" in raw_content:
            raw_content = raw_content[raw_content.find("{"):raw_content.rfind("}") + 1]

        # 1. Clean up markdown wrappers if present.
        raw_content = re.sub(r'^```json\s*|\s*```$', '', raw_content.strip())

        # 2. Fix common malformed numeric tuples from llama-4:
        #    "bounding_box": 0.10, 0.60, 0.55, 0.95,
        # -> "bounding_box": [0.10, 0.60, 0.55, 0.95],
        raw_content = re.sub(
            r'("bounding_box"\s*:\s*)([-+]?\d*\.?\d+)\s*,\s*([-+]?\d*\.?\d+)\s*,\s*([-+]?\d*\.?\d+)\s*,\s*([-+]?\d*\.?\d+)(\s*,?)',
            r'\1[\2, \3, \4, \5]\6',
            raw_content,
        )

        # 3. Fix accidentally concatenated floats.
        raw_content = re.sub(r'(\d\.\d{2,3})([01]\.)', r'\1, \2', raw_content)
        raw_content = re.sub(r'(\d\.\d+)(\d\.\d+)', r'\1, \2', raw_content)
        
        try:
            raw_ai_json = json.loads(raw_content)
        except json.JSONDecodeError as e:
            print(f"JSON Error after cleaning: {e}")
            # Add missing commas between object fields if needed.
            raw_content = re.sub(r'(\}|\]|"\w+")\s*\n\s*("\w+"\s*:)', r'\1,\n\2', raw_content)
            raw_ai_json = json.loads(raw_content)
        
        # Validate through Pydantic
        validated_data = FoodAnalysis(**raw_ai_json)
        
        # 3. Enrich the data
        final_response = {"total_meal_calories": 0, "dishes":[]}
        
        for dish in validated_data.dishes:
            dish_info = {
                "dish_name": dish.dish_name,
                "bounding_box": dish.bounding_box,
                "gravy_detected": dish.gravy_detected,
                "dish_total_calories": 0,
                "ingredients":[]
            }
            
            for ing in dish.ingredients:
                db_macros = match_ingredient_in_db(ing.name, ing.weight_g)
                dish_info["ingredients"].append({
                    "ai_name": ing.name,
                    "db_matched_name": db_macros["name_db"],
                    "weight_g": ing.weight_g,
                    "calories": db_macros["calories"],
                    "protein": db_macros["protein"],
                    "carbs": db_macros["carbs"],
                    "fats": db_macros["fats"],
                    "ai_confidence": db_macros["confidence"]
                })
                dish_info["dish_total_calories"] += db_macros["calories"]
                final_response["total_meal_calories"] += db_macros["calories"]
                
            final_response["dishes"].append(dish_info)

        return final_response

    except Exception as e:
        print(f"Error: {e}")
        raise HTTPException(status_code=500, detail=str(e))
