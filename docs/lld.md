# 🛠️ LOW-LEVEL DESIGN (LLD) DOCUMENT

## 1. System Architecture & Data Flow

**1.1. The Hybrid AI Data Flow (Image Upload Scenario)**
1. **Flutter App:** User captures a Thali. `Google ML Kit` (Edge) instantly detects the plate and crops out the background. Image is compressed to <300KB.
2. **Backend API:** Flutter sends the image via `POST /api/v1/analyze/vision` to your Python (FastAPI) server.
3. **AI Gateway:** FastAPI routes the image via `Portkey` to the `Groq API` (running Llama 3.2 Vision or Qwen-VL).
4. **LLM Inference:** Groq analyzes the image, identifies dishes, and returns a strict JSON deconstruction (Raw Ingredients + Bounding Boxes).
5. **Vector Search:** FastAPI takes the JSON ingredients, converts them to embeddings, and queries `Supabase` (using `pgvector`) to find exact ICMR-NIN database matches.
6. **Calculation & Response:** FastAPI calculates exact macros based on user portion size and sends the final JSON back to Flutter.
7. **Local Cache:** Flutter displays the data, and saves the log locally to `Isar Database` for offline persistence.

---

## 2. Cloud Database Schema (Supabase / PostgreSQL)

We use highly relational tables to prevent data duplication and allow for perfect macro adjustments (like the "Gravy Slider").

### Table: `users`
*Core user metrics and dynamic targets.*
* `id` (UUID, Primary Key)
* `phone_number` (String, Unique)
* `height_cm` (Float)
* `weight_kg` (Float)
* `goal` (Enum: `CUT`, `BULK`, `LEAN`)
* `diet_preference` (Enum: `VEG`, `JAIN`, `VEGAN`, `EGGETARIAN`, `ANY`)
* `experience_level` (Enum: `BEGINNER`, `PRO`)
* `monthly_budget_inr` (Integer)
* `base_tdee` (Integer) - *Recalculates on weight update*
* `created_at` (Timestamp)

### Table: `icmr_ingredients`
*The gold-standard raw ingredient database (Seeded).*
* `id` (UUID, Primary Key)
* `name_en` (String) - *e.g., "Wheat Flour, Whole"*
* `name_hi` (String) - *e.g., "Atta"*
* `embedding` (vector(384)) - *pgvector column for AI semantic search*
* `calories_per_100g` (Float)
* `protein_per_100g` (Float)
* `carbs_per_100g` (Float)
* `fats_per_100g` (Float)
* `is_gravy_base` (Boolean) - *Helps logic for the Gravy Slider*

### Table: `daily_logs`
*The parent container for a specific day.*
* `id` (UUID, Primary Key)
* `user_id` (UUID, Foreign Key)
* `date` (Date)
* `water_ml` (Integer)
* `weather_context` (String) - *e.g., "Delhi_High_AQI"*
* `total_calories_consumed` (Float)

### Table: `meals`
*Represents an eating session (e.g., Lunch).*
* `id` (UUID, Primary Key)
* `daily_log_id` (UUID, Foreign Key)
* `meal_type` (Enum: `BREAKFAST`, `LUNCH`, `DINNER`, `SNACK`)
* `image_url` (String, Nullable) - *Stored securely in Supabase Storage*
* `is_fasting_meal` (Boolean) - *For Navratri/Ramadan logic*

### Table: `meal_items`
*Represents specific dishes within a meal (e.g., Paneer Butter Masala).*
* `id` (UUID, Primary Key)
* `meal_id` (UUID, Foreign Key)
* `dish_name` (String)
* `portion_size` (Float)
* `portion_unit` (Enum: `KATORI`, `LADLE`, `PIECES`, `GRAMS`)
* `gravy_status` (Enum: `FULL`, `HALF`, `PIECES_ONLY`)
* `bounding_box` (JSON) - *e.g., `{"x1":10, "y1":20, "x2":50, "y2":60}`*

### Table: `meal_ingredients`
*The deepest level. Allows user to uncheck "Butter".*
* `id` (UUID, Primary Key)
* `meal_item_id` (UUID, Foreign Key)
* `icmr_ingredient_id` (UUID, Foreign Key)
* `weight_g` (Float)
* `is_excluded_by_user` (Boolean) - *Default `false`. If `true`, omit from macro calculation.*

---

## 3. Local Database Schema (Isar - Flutter Offline Mode)

Isar collections must mirror the essential daily cloud data so the app functions in a gym basement.

```dart
@collection
class LocalDailyPlan {
  Id id = Isar.autoIncrement;
  late DateTime date;
  late int targetCalories;
  late int consumedCalories;
  
  // Stored as JSON strings to avoid complex joins locally
  late String workoutRoutineJson; // Pre-downloaded push/pull routine
  late String pendingSyncLogsJson; // Offline logs waiting for internet
  late bool isSyncedWithCloud;
}
```

---

## 4. API Endpoints (Python / FastAPI)

*Note: Authentication is handled via Supabase JWT headers passed to FastAPI.*

### 4.1. Core AI Analysis Endpoints
**`POST /api/v1/analyze/vision`**
*   **Request:** `multipart/form-data` (Compressed Image, User ID)
*   **Logic:** Routes to Groq Vision API -> Vector Search -> Macro Calculation.
*   **Response:**
    ```json
    {
      "confidence_score": 0.92,
      "dishes":[
        {
          "dish_name": "Paneer Butter Masala",
          "bounding_box":[120, 45, 300, 250],
          "default_portion_unit": "KATORI",
          "gravy_detected": true,
          "ingredients":[
            {"name": "Paneer", "id": "uuid-1", "weight_g": 100, "macros": {...}},
            {"name": "Butter", "id": "uuid-2", "weight_g": 15, "macros": {...}}
          ]
        }
      ]
    }
    ```

**`POST /api/v1/analyze/voice`**
*   **Request:** Audio File or transcribed text ("Maine 2 roti khayi")
*   **Logic:** Groq Text API (Llama 3) translates Hinglish to JSON ingredient array -> Vector Search.

**`GET /api/v1/barcode/scan/{barcode_number}`**
*   **Logic:** Pings OpenFoodFacts API. Falls back to Groq if the barcode package text needs OCR extraction.

### 4.2. State Management & Sync Endpoints
**`POST /api/v1/sync/offline`**
*   **Request:** JSON payload from Isar containing an array of locally logged meals/workouts.
*   **Logic:** Batch inserts into Supabase. Resolves timestamp conflicts.

**`PATCH /api/v1/meals/ingredient/{ingredient_id}/toggle`**
*   **Request:** `{"is_excluded": true}`
*   **Logic:** Toggles the boolean in `meal_ingredients`, recalculates total meal calories, and returns updated macros.

---

## 5. The AI Processing Pipeline (Prompt Design)

To ensure the Groq model does not hallucinate, the System Prompt sent via Portkey must be engineered perfectly. 

**System Prompt Example (Groq Vision):**
> "You are an expert Indian Nutritionist. Analyze this image. 
> 1. Identify distinct Indian dishes.
> 2. Provide a 2D bounding box `[x_min, y_min, x_max, y_max]` for each dish.
> 3. Deconstruct each dish into its raw ingredients (e.g., Atta, Ghee, Paneer, Onion). Do NOT provide a final calorie count. 
> 4. Estimate the raw ingredient weight assuming 1 standard serving. 
> 5. Output strictly in JSON format. Do not include markdown or conversational text."

---

## 6. Frontend Architecture (Flutter Modules)

Follow **Domain-Driven Design (DDD)** using `Riverpod` or `Bloc` for state management.

*   **`lib/features/onboarding/`**: Height, Weight, DPDP photo capture, Goal selection.
*   **`lib/features/camera_logger/`**: 
    *   `ml_kit_service.dart`: Handles on-device cropping.
    *   `bounding_box_painter.dart`: Custom canvas drawing the visual boxes over the Thali.
*   **`lib/features/meal_editor/`**: 
    *   The Gravy Slider UI.
    *   Ingredient Checkboxes (Riverpod state updates macros locally instantly before sending the `PATCH` sync to the server).
*   **`lib/features/offline_gym/`**: Pulls workout template from Isar, handles check-ins, saves to local pending-sync queue.
*   **`lib/core/network/`**: Supabase Client and Interceptors for checking network status (triggers Isar fallback if ping fails).