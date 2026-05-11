# Features to Add Later

## 1. Bulk Meal Logging Endpoint (`/api/v1/meals/bulk-log`)
- **Current State:** The flutter `SyncService` loops through unsynced meals and posts them one-by-one.
- **Future Goal:** Build a batch endpoint in the Python backend to accept a JSON array of `MealLogRequest` models. This will drastically reduce network calls, save mobile battery life, and ensure atomic bulk transactions in Supabase.

## 2. Bounding Box Mathematical Alignment Fix
- **Current State:** A temporary manual scaling matrix was applied in `BoundingBoxPainter`, but `BoxFit.contain` introduces letterboxing constraints that still aren't fully mathematically aligning dynamic AI matrices on all screen aspect ratios.
- **Future Goal:** Complete a deeper mathematical review of bounding box coordinates plotting `[y_min, x_min, y_max, x_max]` over the raw Image dimensions vs the rendered UI constraints. Consider switching to bounding boxes mapped relative to the strict `ImageProvider` resolution rather than `CustomPainter` canvas space.

## 3. Background Workers for Context-Aware Engine
- **Current State:** The weather fetching and hydration adjustments currently happen strictly in the foreground when the app is launched or the dashboard is built.
- **Future Goal:** Integrate the `workmanager` package to run background isolates. This will allow the app to securely ping location/weather APIs while closed in the user's pocket, enabling real-time local push notifications if the temperature spikes unexpectedly.
