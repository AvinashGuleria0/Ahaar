import os
from supabase import create_client, Client
from sentence_transformers import SentenceTransformer
from dotenv import load_dotenv

load_dotenv()

# 1. Setup Supabase Client
SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")
supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

# 2. Load the AI Embedding Model (Runs instantly since it's cached now)
model = SentenceTransformer('all-MiniLM-L6-v2')

def get_ingredient_macros(search_term, weight_in_grams):
    print(f"\n🔍 Searching AI Database for: '{search_term}'...")
    
    # Convert the search term into a math vector
    query_vector = model.encode(search_term).tolist()
    
    # Call our Supabase RPC function!
    # We ask for the top 1 match, with at least 50% similarity
    response = supabase.rpc(
        'match_ingredients', 
        {'query_embedding': query_vector, 'match_threshold': 0.5, 'match_count': 1}
    ).execute()
    
    matches = response.data
    
    if not matches:
        print(f"❌ No matching ingredient found in ICMR database.")
        return
        
    best_match = matches[0]
    similarity = best_match['similarity'] * 100
    
    # The database stores data per 100g, so we calculate for the actual weight eaten
    multiplier = weight_in_grams / 100.0
    
    total_calories = float(best_match['calories_per_100g']) * multiplier
    total_protein = float(best_match['protein_per_100g']) * multiplier
    
    print(f"✅ Found: {best_match['name_en']} ({best_match['name_hi']})")
    print(f"🧠 AI Match Confidence: {similarity:.1f}%")
    print(f"⚖️ Portion: {weight_in_grams}g")
    print(f"🔥 Calories: {total_calories:.1f} kcal | 🥩 Protein: {total_protein:.1f}g")
    print("-" * 50)

if __name__ == "__main__":
    # Let's simulate the JSON Groq gave us earlier!
    # Groq said: "Whole Wheat Flour", 80g
    get_ingredient_macros("Whole Wheat Flour", 80)
    
    # Groq said: "Ghee", 5g
    get_ingredient_macros("Clarified Butter Ghee", 5)
    
    # Let's test the AI's "understanding" with a Hinglish typo:
    get_ingredient_macros("Safed Chawal (White rice)", 150)