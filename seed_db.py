import os
from supabase import create_client, Client
from sentence_transformers import SentenceTransformer
from dotenv import load_dotenv

load_dotenv()

# 1. Setup Supabase Client
# Get these from Supabase Dashboard -> Project Settings -> API
SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

# 2. Load the Local Embedding Model
# This specific model creates 384-dimensional vectors (matching our SQL schema)
print("Loading AI Embedding Model (this takes a few seconds the first time)...")
model = SentenceTransformer('all-MiniLM-L6-v2')

# 3. Create some dummy ICMR data based on your dinner JSON!
dummy_ingredients =[
    {
        "name_en": "Split Red Lentils",
        "name_hi": "Masoor Dal",
        "calories_per_100g": 343, "protein_per_100g": 24, "carbs_per_100g": 60, "fats_per_100g": 1.5,
        "fiber_per_100g": 30, "is_vegetarian": True, "is_vegan": True
    },
    {
        "name_en": "White Rice",
        "name_hi": "Safed Chawal",
        "calories_per_100g": 130, "protein_per_100g": 2.7, "carbs_per_100g": 28, "fats_per_100g": 0.3,
        "fiber_per_100g": 0.4, "is_vegetarian": True, "is_vegan": True
    },
    {
        "name_en": "Whole Wheat Flour",
        "name_hi": "Atta",
        "calories_per_100g": 340, "protein_per_100g": 13.2, "carbs_per_100g": 72, "fats_per_100g": 2.5,
        "fiber_per_100g": 10.7, "is_vegetarian": True, "is_vegan": True
    },
    {
        "name_en": "Clarified Butter",
        "name_hi": "Ghee",
        "calories_per_100g": 900, "protein_per_100g": 0, "carbs_per_100g": 0, "fats_per_100g": 100,
        "saturated_fat_per_100g": 60, "is_vegetarian": True, "is_vegan": False, "is_dairy_free": False
    }
]

def seed_database():
    print("Generating embeddings and inserting into Supabase...")
    
    for item in dummy_ingredients:
        # Generate the 384-number array representing the English + Hindi name
        search_text = f"{item['name_en']} {item['name_hi']}"
        embedding_vector = model.encode(search_text).tolist()
        
        # Add the vector to our dictionary
        item["embedding"] = embedding_vector
        
        # Insert into Supabase
        data, count = supabase.table("icmr_ingredients").insert(item).execute()
        print(f"✅ Inserted: {item['name_en']}")

    print("🎉 Database successfully seeded!")

if __name__ == "__main__":
    seed_database()