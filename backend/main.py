import os
import base64
import json
import re
import uuid
from fastapi import FastAPI, UploadFile, File, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List
from openai import OpenAI
from supabase import create_client, Client
from sentence_transformers import SentenceTransformer
from dotenv import load_dotenv

from schemas import (
    UserCreate, 
    UserResponse, 
    MealLogRequest, 
    MealLogResponse, 
    DailyLogResponse, 
    MealLogSuccessResponse
)
from services import calculate_advanced_macros

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
# Initialize Local Ollama Client (No API key needed)
local_client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama",
)
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
        model_id = "gemma4:e2b"

        # 2. Ask local Ollama model to analyze the image
        print(f"🚀 Sending to local Ollama model: {model_id}...")
       
        system_prompt = """ 
            You are an expert Indian nutritionist and computer vision assistant specializing in meal analysis.

Your task is to analyze a food image and identify all visible dishes with high accuracy, even in complex meals like Indian thalis.

Follow these STRICT rules:

-------------------------------
CORE OBJECTIVE
-------------------------------
1. Detect ALL distinct food items (including small bowls, condiments, sides, desserts, breads, rice, etc.).
2. Treat each visually separable food portion as a separate "dish".
3. If multiple items are in one container but clearly different (e.g., rice + curry), split them into separate dishes.

-------------------------------
BOUNDING BOX RULES
-------------------------------
1. Each dish MUST have a bounding box in format:
   [y_min, x_min, y_max, x_max]
2. Coordinates MUST be integers between 0 and 1000.
3. Boxes should tightly enclose the food item (not the entire plate).
4. Do NOT merge numbers. Always format like:
   [120, 340, 560, 780]

-------------------------------
FOOD IDENTIFICATION RULES
-------------------------------
1. Use common Indian dish names when possible:
   e.g., "dal tadka", "paneer butter masala", "jeera rice", "roti", "papad", "gulab jamun", "pickle", "raita"
2. If unsure, use descriptive fallback:
   e.g., "mixed vegetable curry", "fried snack", "lentil curry"
3. Identify:
   - breads (naan, roti, dosa)
   - rice dishes
   - gravies
   - dry sabzi
   - chutneys
   - desserts
   - salads

-------------------------------
GRAVY DETECTION
-------------------------------
Set "gravy_detected": true if:
- The dish is liquid/semi-liquid (dal, curry, sambhar, kadhi, etc.)
Otherwise false.

-------------------------------
INGREDIENT ESTIMATION
-------------------------------
1. List 3–8 likely ingredients per dish.
2. Assign realistic approximate weights in grams.
3. Use domain knowledge of Indian cooking.
4. Keep total per dish realistic (50g–400g depending on item).

Example:
{"name": "tomato", "weight_g": 40.0}

-------------------------------
EDGE CASE HANDLING
-------------------------------
1. If items overlap → still detect separately.
2. If very small (pickle, chutney) → still include.
3. If uncertain → make best educated guess (DO NOT skip).
4. If identical items appear multiple times → treat as separate entries ONLY if spatially distinct.

-------------------------------
OUTPUT FORMAT (STRICT)
-------------------------------
Return ONLY valid JSON. No explanation. No markdown.

{
  "dishes": [
    {
      "dish_name": "Name",
      "bounding_box": [y_min, x_min, y_max, x_max],
      "gravy_detected": true,
      "ingredients": [
        {"name": "Ingredient", "weight_g": 100.0}
      ]
    }
  ]
}

-------------------------------
CRITICAL CONSTRAINTS
-------------------------------
- Output MUST be valid JSON.
- No trailing commas.
- No text outside JSON.
- All numbers must be separate (no merging).
- Always return at least 5–15 dishes for complex thali images.

        """
        
        chat_completion = local_client.chat.completions.create(
            messages=[
                {"role": "system", "content": system_prompt},
                {
                    "role": "user",
                    "content": [
                        {"type": "text", "text": "Analyze this Indian plate and return JSON. Ensure bounding_box has 4 distinct comma-separated floats on a 0-1000 scale."},
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

@app.post("/api/v1/users/profile", response_model=UserResponse, status_code=status.HTTP_201_CREATED)
async def create_user_profile(user_data: UserCreate):
    try:
        # Calculate macros using our advanced engine
        calculated_macros = calculate_advanced_macros(user_data)
        
        # Convert Pydantic model to dictionary, converting Enum types to exact strings
        db_data = user_data.model_dump(mode='json')
        
        # Generate random UUID for auth_id as requested
        db_data["auth_id"] = str(uuid.uuid4())
        
        # Merge calculated macros
        db_data.update(calculated_macros)
        
        # Insert everything directly into the Supabase target table
        response = supabase.table("users").insert(db_data).execute()
        
        if not response.data:
            raise HTTPException(status_code=400, detail="Supabase Insertion Failed: No data returned")
            
        return response.data[0]
        
    except Exception as e:
        print(f"Profile creation error: {e}")
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e))

@app.post("/api/v1/meals/log", response_model=MealLogSuccessResponse, status_code=status.HTTP_201_CREATED)
async def log_meal(request: MealLogRequest):
    try:
        user_id_str = str(request.user_id)
        log_date_str = request.log_date.isoformat()
        
        # 1. Check if a row exists in daily_logs for this user_id and log_date
        daily_logs_query = supabase.table("daily_logs").select("*").eq("user_id", user_id_str).eq("log_date", log_date_str).execute()
        
        daily_log_id = None
        current_daily_totals = None
        
        # 2. If it does NOT exist, create a new row
        if not daily_logs_query.data:
            try:
                insert_daily_log = supabase.table("daily_logs").insert({
                    "user_id": user_id_str,
                    "log_date": log_date_str
                    # Other fields default to 0 through Postgres schema logic
                }).execute()
                
                if not insert_daily_log.data:
                    raise HTTPException(status_code=500, detail="Failed to initialize daily log row.")
                
                current_daily_totals = insert_daily_log.data[0]
                daily_log_id = current_daily_totals["id"]
                
            except Exception as insert_e:
                # Handle potential race condition where another request created the daily_log an instant before
                # (Postgres unique constraint violation on user_id + log_date)
                error_str = str(insert_e)
                if "23505" in error_str or "unique constraint" in error_str.lower():
                    # Re-fetch gracefully
                    re_fetch = supabase.table("daily_logs").select("*").eq("user_id", user_id_str).eq("log_date", log_date_str).execute()
                    if not re_fetch.data:
                        raise HTTPException(status_code=500, detail="Race condition failed to resolve on daily_logs.")
                    current_daily_totals = re_fetch.data[0]
                    daily_log_id = current_daily_totals["id"]
                else:
                    raise HTTPException(status_code=400, detail=f"Database constraint error: {error_str}")
        else:
            # Row existed, retrieve the exact data payload
            current_daily_totals = daily_logs_query.data[0]
            daily_log_id = current_daily_totals["id"]
            
        # 3. Insert a new row into the meals table
        meal_insert_payload = {
            "daily_log_id": daily_log_id,
            "meal_type": request.meal_type.value, # Enum to string
            "meal_calories": request.meal_calories,
            "meal_protein_g": request.meal_protein_g
        }
        
        meal_insert_res = supabase.table("meals").insert(meal_insert_payload).execute()
        if not meal_insert_res.data:
            raise HTTPException(status_code=500, detail="Failed to insert meal specifics.")
            
        inserted_meal = meal_insert_res.data[0]
        
        # 4. Update the daily_logs table by adding the meal's specific macros.
        # We explicitly calculate via fetched Python data to prevent stale state overwrites
        new_totals = {
            "consumed_calories": float(current_daily_totals.get("consumed_calories", 0) or 0) + request.meal_calories,
            "consumed_protein_g": float(current_daily_totals.get("consumed_protein_g", 0) or 0) + request.meal_protein_g,
            "consumed_carbs_g": float(current_daily_totals.get("consumed_carbs_g", 0) or 0) + request.meal_carbs_g,
            "consumed_fats_g": float(current_daily_totals.get("consumed_fats_g", 0) or 0) + request.meal_fats_g,
            "consumed_fiber_g": float(current_daily_totals.get("consumed_fiber_g", 0) or 0) + request.meal_fiber_g,
            "consumed_sugar_g": float(current_daily_totals.get("consumed_sugar_g", 0) or 0) + request.meal_sugar_g,
            "consumed_sodium_mg": float(current_daily_totals.get("consumed_sodium_mg", 0) or 0) + request.meal_sodium_mg,
        }
        
        update_res = supabase.table("daily_logs").update(new_totals).eq("id", daily_log_id).execute()
        
        if not update_res.data:
            raise HTTPException(status_code=500, detail="Failed to calculate and update daily totals properly.")
            
        updated_daily_totals = update_res.data[0]
        
        # 5. Return success structured tightly against our new schemas
        return {
            "message": "Meal logged successfully",
            "meal": inserted_meal,
            "daily_totals": updated_daily_totals
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"Meal Log error: {e}")
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e))
