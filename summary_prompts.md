Task 1: Implementation summary.
- Created `schemas.py` containing Pydantic v2 data models for user profiles.
- Added strict Python `Enum` classes (e.g., `Gender`, `Goal`, `ActivityLevel`) mirroring the Postgres SQL `CHECK` constraints to ensure 100% type safety and zero-error API payloads.
- Implemented a clean, DRY inheritance structure using `UserBase`, `UserCreate` (input payload from Flutter), and `UserResponse` (output payload with auto-generated UUIDs and computed targets).

Task 2: Implementation summary.
- Created `services.py` featuring a `calculate_advanced_macros(user_data)` utility.
- Added explicit caloric multipliers (Protein: 4, Fat: 9, Carbs: 4) at the top of the file as constants for transparency.
- Integrated the Mifflin-St Jeor equation to compute BMR based on weight, height, age, and gender demographics, adjusted by activity level to get TDEE.
- Applied intelligent boundary guardrails: adjusted `target_weight_kg` for protein to restrict massive caloric assignments, set a TDEE floor deficit constraint for `lean_physique`, established a minimum starvation limit (1200 kcal), and guaranteed a 50g minimum carbohydrate floor.
- Adjusted fiber targets (35g for PCOS/Diabetes) and water recommendations (+500ml for high weight / highly active users).

Task 3: Implementation summary.
- Updated `main.py` adding the `POST /api/v1/users/profile` endpoint returning standard `HTTP_201_CREATED`.
- Used Pydantic v2's `model_dump(mode='json')` serialization to ensure advanced `Enum` types drop down safely to native Python strings before hitting the Supabase client.
- Injected `uuid.uuid4()` dynamically for independent `auth_id` creation.
- Successfully merged computed outputs from `calculate_advanced_macros` natively with user-data dictionary strings, successfully orchestrating a perfect `users` table save payload.
- Guarded database integration via robust `HTTPException(status_code=400)` wrap arounds for unique table constraint overrides and potential schema breaks.

Phase 2: The "Daily Log" System
Task 1: Implementation summary.
- Created `MealType` string explicitly mapping the Postgres `CHECK` array constraints ('breakfast', 'lunch', 'snack', 'dinner', 'dessert', 'late_night').
- Developed the core `MealLogRequest` schema using Pydantic v2 `Field(default=0.0)` for safe data ingestion when tracking specific zero-calorie items. Added `ge=0.0` guardrails to prevent users from hacking calorie deficits by sending negative macros payload logic from Flutter.
- Instituted the `MealLogResponse` model mimicking the exact output shape of the Postgres `meals` table insertion response (with auto-generated uuid, `daily_log_id`, and `logged_at` timestamps).
- Engineered the scalable `DailyLogResponse` and `MealLogSuccessResponse` models representing the parent returning node to the Flutter app.

Task 2: Implementation summary.
- Wrote the transactional endpoint logic for `POST /api/v1/meals/log`.
- Built a race-condition immune Upsert-Check layer: Explicitly trapping the Python `23505 Unique Constraint` error to immediately re-poll Supabase if two requests try to create a `daily_logs` instance at the exact millisecond instead of breaking the User UI.
- Securely mapped Pydantic `request.meal_type.value` Enum extractions into Supabase compatible strings.
- Aggregated daily limits programmatically via `float(current_cals) + float(meal_cals)` mathematically safeguarding variable typing conflicts on the SQL JSON serialization backflow.
- Encapsulated step-by-step 500/400-level `HTTPExceptions` mapping throughout the Upsert process yielding immediate exact feedback traces to aid debugging and frontend routing.
