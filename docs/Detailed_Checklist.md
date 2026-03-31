
# ✅ THE MASTER PROJECT CHECKLIST

### 1. 🧑‍🤝‍🧑 Onboarding & User Profile (The Foundation)
- [ ] **Basic Metrics:** Collect Height, Weight, Age, and Gender.
- [ ] **Goal Selection:** User selects Cut (lose fat), Bulk (gain muscle), or Lean Physique.
- [ ] **Experience Level:** Beginner vs. Gym Bro (determines UI complexity: simple rings vs. exact macro grams).
- [ ] **Dietary Preferences & Allergies:** Options for "Strictly Vegetarian", "Eggetarian", "Vegan", "Jain (No onion/garlic)", and "Lactose Intolerant". (AI must strictly filter recipes based on this).
- [ ] **Budget Input:** Collect daily/monthly food budget to recommend affordable protein (e.g., Sattu, Soya Chunks, Black Chana) instead of expensive imports.
- [ ] **Privacy-First Body Photos (DPDP Compliant):** Allow user to take a baseline physique photo. 
  - [ ] *Crucial Detail:* Image is saved *only* to local device storage (Isar DB/Gallery). Never uploaded to cloud.
- [ ] **Baseline Calorie Calculation:** Use Mifflin-St Jeor equation to calculate initial Total Daily Energy Expenditure (TDEE).

### 2. 📸 Multi-Modal Food Logging (The Inputs)
- [ ] **Edge AI Camera (ML Kit):** Camera instantly verifies "Is this food?" and crops the image locally before sending to save bandwidth.
- [ ] **Photo Upload (Groq Vision):** Send image to Groq API running open-source Vision (Llama/Qwen) for sub-second processing.
- [ ] **Voice Logging (Hinglish):** Mic button for "Maine 2 roti aur peeli dal khayi."
- [ ] **Text Logging:** Standard manual text search.
- [ ] **Barcode Scanner:** Integrate `OpenFoodFacts` API for instant, 100% accurate logging of Indian packaged goods (Amul, Haldiram, MuscleBlaze, Maggi).
- [ ] **Text-to-Image (Premium Feature):** If a user types "2 rotis and dal", generate an AI image (using a model like Flux) so they can visually see their logged meal.

### 3. 🧠 AI Vision, Thali Breakdown & UX (The "Indian Context")
- [ ] **Thali Bounding Boxes:** AI returns coordinates `[x,y]` for multiple items on a plate. Flutter app draws visual bounding boxes/arrows identifying "Roti", "Dal", "Sabzi".
- [ ] **Confidence Score Fallback:** If AI is <60% sure, it gives 3-4 closest options and asks the user to manually confirm.
- [ ] **The "Raw Ingredient / Chef" Deconstruction:** AI doesn't guess "Paneer Masala = 400 cal". It breaks it down into raw ingredients (100g Paneer, 10g Ghee, 20g Onion/Tomato base).
-[ ] **Portion Size Confirmation:** AI prompts user to confirm size using Indian metrics:
  - [ ] Small Katori (150ml)
  - [ ] Large Bowl (300ml)
  - [ ] 1 Ladle (Karchhi)
  - [ ] Number of pieces / Tablespoons.
- [ ] **The Gravy Slider:** Toggle for "Full Gravy", "Half Gravy", or "Only Pieces" to prevent calorie dilution.
- [ ] **Ingredient Checkboxes (Edit AI):** Show AI's ingredient breakdown. User can uncheck "Cream" or "Butter". Calories auto-recalculate instantly.
- [ ] **The "Add Dessert/More" Button:** Allow users to append an item to an *existing* meal log 30 mins later, without creating a new meal entry.
- [ ] **Meal Memory:** If user logs "Mom's Dal" 3 times with specific edits, save it as a custom recognized food so the AI stops asking.
- [ ] **Family/Household Scaling:** Option to scale a recipe (e.g., "I cooked dal for 4 people, I ate 1 portion").

### 4. 🗄️ Database & Vector Matching (The Brains)
-[ ] **ICMR-NIN Seeding:** Import the official Indian Council of Medical Research raw ingredient database into PostgreSQL.
- [ ] **Hinglish Translation Prompt:** AI standardizes inputs before searching (e.g., translates "Peeli Dal" to "Yellow Lentils").
- [ ] **Vector Search (`pgvector` in Supabase):** AI embeddings match the extracted ingredients to the exact ICMR database items perfectly.

### 5. 🏋️‍♂️ Workout & Context-Aware Ecosystem
- [ ] **Hardcoded Gym Templates (MVP):** Route users to Push/Pull/Legs, Upper/Lower, or Home Workout based on goals and gym access.
- [ ] **Offline Gym Basement Mode:** 
  - [ ] Every morning, cache the day's diet and workout to `Isar` local database.
  - [ ] Allow full workout checking and text logging with zero internet.
  - [ ] Auto-sync to Supabase when 4G/5G is restored.
- [ ] **Weather & Location Aware Tracker:**
  - [ ] Pull location weather API.
  - [ ] Suggest higher water intake on 40°C summer days.
  - [ ] Alert user on high pollution days (e.g., Delhi AQI > 300) to skip outdoor runs and suggest indoor cardio.
- [ ] **Festive / Fasting Mode:** Dedicated macros and food databases for Navratri, Ramadan, and Ekadashi.

### 6. 🎮 Gamification, Streaks & Progression
- [ ] **Daily Rings:** Apple Watch-style rings for Calories, Protein, Carbs, Fats.
- [ ] **Calorie Deduction Logic:** Start with goal (e.g., 3000 cal). As meals are logged, perfectly deduct calories dynamically.
- [ ] **Dynamic Progression Alerts:** When user logs weight loss/gain, show popup: *"Congrats on losing 2kg! Your metabolism has changed. Here is your new macro breakdown."*
- [ ] **Smart Reminders:** Push notifications reminding them to hit the gym based on their template.
-[ ] **Progress Check-ins:** Monthly prompts to take a new physique photo (saved locally) to view side-by-side progress.

### 7. 💳 Monetization, Limits & Subscriptions
- [ ] **Free Demo Tier:** 
  - [ ] 3-day free trial.
  - [ ] Strict limit of 5 photo scans per day.
  - [ ] Runs on Groq (Llama/Qwen open source) for cost efficiency.
- [ ] **Premium Tier:**
  - [ ] Unlimited photo scans.
  - [ ] Unlocks ultra-precise GPT-4o Vision for complex meals.
  - [ ] Unlocks Text-to-Image meal visualization.
  - [ ] Completely personalized exact macro tracking.
- [ ] **Future Roadmap (Placeholders to build architecture for):**
  - [ ] *Grocery List Generator:* Tie budget/diet to Blinkit/Zepto API.
  - [ ] *Coach Portal:* SaaS dashboard for real dietitians to monitor clients.
  - [ ] *Sleep Tracking Integration:* Affects daily recovery metrics.

### 8. 🏗️ Infrastructure & Tech Stack Setup
- [ ] **Frontend Environment:** Initialize Flutter project.
- [ ] **Local Storage:** Setup `Isar` DB for Flutter.
- [ ] **Backend Environment:** Initialize Python `FastAPI` application.
- [ ] **Database & Auth:** Setup `Supabase` project.
  - [ ] Configure PostgreSQL tables.
  - [ ] Enable `pgvector` extension.
  - [ ] Setup Google/Apple/Mobile OTP authentication.
- [ ] **AI Gateway:** Integrate `Portkey` or `Helicone`.
  - [ ] Setup API keys for Groq.
  -[ ] Implement prompt caching (to save tokens on common food scans).
- [ ] **Edge AI Setup:** Integrate Google `ML Kit` Vision dependency into Flutter `pubspec.yaml`.

---

Every single brain-dump, micro-feature, and edge case from our conversation is strictly documented above. 

When you are ready, let me know if you want the **Low-Level Design (LLD)** for the Database architecture, or the LLD for the Backend API endpoints!