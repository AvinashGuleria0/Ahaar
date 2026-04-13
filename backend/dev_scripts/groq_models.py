import os
from groq import Groq
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Initialize client
client = Groq(api_key=os.getenv("GROQ_API_KEY"))

models = client.models.list()
for model in models.data:
    if "vision" in model.id or "llama-4" in model.id:
        print(model.id)