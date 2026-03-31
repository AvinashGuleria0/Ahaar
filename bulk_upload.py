import os
import csv
from supabase import create_client, Client
from sentence_transformers import SentenceTransformer
from dotenv import load_dotenv

load_dotenv()

# 1. Setup Supabase
SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY") # Ensure this is your Service Role Key!
supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

# 2. Load Embedding Model
print("🧠 Loading AI Embedding Model...")
model = SentenceTransformer('all-MiniLM-L6-v2')

def clean_boolean(val):
    return str(val).strip().lower() == 'true'

def bulk_upload(csv_filepath):
    print(f"📂 Reading data from {csv_filepath}...")
    
    batch_size = 50 # Upload 50 items at a time
    current_batch =[]
    
    with open(csv_filepath, mode='r', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        
        for row in reader:
            # 1. Create the search text (English + Hindi)
            search_text = f"{row['name_en']} {row['name_hi']}"
            
            # 2. Generate the AI Vector
            embedding_vector = model.encode(search_text).tolist()
            
            # 3. Format the database row safely
            db_row = {
                "name_en": row['name_en'],
                "name_hi": row['name_hi'],
                "calories_per_100g": float(row['calories_per_100g'] or 0),
                "protein_per_100g": float(row['protein_per_100g'] or 0),
                "carbs_per_100g": float(row['carbs_per_100g'] or 0),
                "fats_per_100g": float(row['fats_per_100g'] or 0),
                "fiber_per_100g": float(row['fiber_per_100g'] or 0),
                "is_vegetarian": clean_boolean(row['is_vegetarian']),
                "is_vegan": clean_boolean(row['is_vegan']),
                "is_jain": clean_boolean(row['is_jain']),
                "embedding": embedding_vector
            }
            
            current_batch.append(db_row)
            
            # 4. If batch is full, push to Supabase!
            if len(current_batch) >= batch_size:
                print(f"🚀 Pushing batch of {batch_size} ingredients to Supabase...")
                supabase.table("icmr_ingredients").insert(current_batch).execute()
                current_batch =[] # Reset batch
                
        # 5. Push any remaining items
        if len(current_batch) > 0:
            print(f"🚀 Pushing final batch of {len(current_batch)} ingredients to Supabase...")
            supabase.table("icmr_ingredients").insert(current_batch).execute()

    print("✅ Bulk upload completed successfully!")

if __name__ == "__main__":
    bulk_upload("icmr_data.csv")