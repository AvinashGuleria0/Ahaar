import os
import base64
from groq import Groq
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Initialize Groq client
client = Groq(api_key=os.getenv("GROQ_API_KEY"))

# Function to convert your image into a format the AI can read
def encode_image(image_path):
    with open(image_path, "rb") as image_file:
        return base64.b64encode(image_file.read()).decode('utf-8')

def analyze_food(image_path):
    print(f"Analyzing {image_path}... sending to Groq LPU 🚀")
    base64_image = encode_image(image_path)
    
    # The Master System Prompt we designed
    system_prompt = """
    You are an expert Indian Nutritionist and AI Vision Assistant.
    Analyze this image of an Indian meal. 
    1. Identify distinct Indian dishes.
    2. Provide a 2D bounding box[x_min, y_min, x_max, y_max] for each dish.
    3. Deconstruct each dish into its RAW ingredients (e.g., Atta, Ghee, Paneer, Onion, Mustard Oil). Do NOT provide a final calorie count. 
    4. Estimate the raw ingredient weight in grams assuming 1 standard serving.
    5. Output STRICTLY in JSON format matching this structure:
    {
      "dishes":[
        {
          "dish_name": "Name",
          "bounding_box": [0,0,0,0],
          "gravy_detected": true/false,
          "ingredients": [ {"name": "Ingredient", "weight_g": 0} ]
        }
      ]
    }
    """

    # We use Llama 3.2 90B Vision because it is the smartest open-source vision model on Groq right now
    chat_completion = client.chat.completions.create(
        messages=[
            {
                "role": "system",
                "content": system_prompt
            },
            {
                "role": "user",
                "content":[
                    {"type": "text", "text": "Analyze this Indian plate and return the JSON."},
                    {
                        "type": "image_url",
                        "image_url": {
                            "url": f"data:image/jpeg;base64,{base64_image}",
                        },
                    },
                ],
            }
        ],
        model="meta-llama/llama-4-scout-17b-16e-instruct", 
        response_format={"type": "json_object"}, # This forces the AI to ONLY output valid JSON
        temperature=0.1 # Low temperature so it doesn't hallucinate creative ingredients
    )

    # Print the raw JSON result
    print("\n✅ AI Response JSON:")
    print(chat_completion.choices[0].message.content)

if __name__ == "__main__":
    # Make sure dinner.jpg is in the same folder as this script
    analyze_food("assets/dinnernorth.jpg")