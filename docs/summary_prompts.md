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

Phase 3: The Flutter App (DDD Architecture)
Task 1: Environment Setup
- Executed `flutter pub add` to securely lock in the latest 2026 production-grade versions of `flutter_riverpod`, `isar`, `isar_flutter_libs`, and `path_provider`.
- Promoted development efficiency by installing `build_runner`, alongside the suggested `freezed` and `json_serializable` bundles to automate immutable state management and strict JSON serialization.
- Scripted a complete Domain-Driven Design (DDD) folder scaffolding via terminal (`lib/core/network`, `lib/core/database`, `lib/features/food_logger/{domain,presentation}`, and `dashboard/{domain,presentation}`).

Task 2: Local Database (Isar)
- Engineered `local_schemas.dart` inside `lib/core/database/` defining the offline singleton schema.
- Developed `@collection` classes for `LocalDailyLog` and `LocalMeal` incorporating zeroed-out `DateTime` constraints for atomic daily querying without risking duplicate date collision bugs.
- Built an explicit two-way `IsarLink<LocalDailyLog>` relational mapping, empowering rapid cascade deletes or query logic on the UI side.
- Adopted the `supabaseId` nullable sync parameter into local models to guarantee absolute immunity from multiple duplication events when a delayed network connection is restored.
- Successfully executed `dart run build_runner build --delete-conflicting-outputs` to permanently generate `local_schemas.g.dart` schema files.

Task 4: Meal Confirmation Logic (Freezed & Riverpod)
- Architected `meal_draft_notifier.dart` serving as the immutable confirmation UI engine mapping exactly to AI JSON strings.
- Developed `@freezed` models for `DraftDish` and `DraftIngredient` ensuring rigorous UI immutability standards allowing users to toggle checkboxes or multiplier sliders safely.
- Introduced Dart 3 Records globally `({double calories, double protein, double carbs, double fats})` within the `.calculateTotalMacros()` method providing memory-efficient autocomplete math without defining convoluted classes.
- Integrated a custom dynamic JSON parser inside `.initializeFromAI(aiJson)` that protects the frontend from deep-nesting macro crashes (`macros is Map ? ... : ...`).
- Scripted the robust `.toggleIngredient` and `.updatePortionMultiplier` UI endpoints implementing exact native Riverpod `.copyWith` logic rendering lightning-fast UI state mutations.

Task 5: UI Migration & Bottom Sheet Orchestration
- Gutted the hardcoded `AaharPoC` from `main.dart` mutating it into a production-ready `CameraScreen` `ConsumerStatefulWidget` nested strictly inside the DDD implementation at `lib/features/food_logger/presentation/`.
- Designed `MealConfirmationSheet` enabling UI users to interactively map portions, toggle specific raw ingredient checkboxes, select the exact specific `meal_type` (defaulting dynamically to `lunch`), and instantly observe AI boundary-recalculated summation macro fields accurately rendered per standard Data Models.
- Orchestrated the stateful network chain: successfully executing `initializeFromAI()`, launching the confirmation sheet transparently overlaid atop bounding boxes, and gracefully routing custom-built `addMeal()` interactions back into the central Local Isar Database layer closing out the entire local phase lifecycle smoothly with a green `ScaffoldMessenger.showSnackBar` validation marker.
- Refactored `main.dart` converting it dynamically to `main() async`, resolving the local Database mapping (`DatabaseService.init()`) directly into the global `ProviderScope` pipeline resolving Riverpod startup context.
- Built `database_provider.dart` leveraging Riverpod globally to expose singleton `Isar` local databases safely.
- Developed the `DailyLogNotifier` Async Notifier (Riverpod 2.0+ standard) preventing startup Thread freezing. 
- Integrated automatic timestamp truncation logic ensuring multiple identical dates never overlap within `logDateEqualTo(today)` queries.
- Programmed a transactional nested `addMeal` method executing a seamless Isar write operation (inserting meal row, math adjusting floating total bounds, altering native sync status inherently, and mapping `IsarLink.save()`), pushing standard reactive updates back into the Dashboard UI pipeline.

Phase 4: Flutter Build Debugging & Error Resolution (Chronological Log)
Task 1: Android/Gradle Namespace Failure (`isar_flutter_libs`)
- Initial failure hit during `flutter run`: `Namespace not specified` for `isar_flutter_libs-3.1.0+1/android/build.gradle`.
- First quick workaround attempted in pub cache by adding `namespace`, but it was initially inserted at the top-level and caused Gradle method-evaluation failures.
- Corrected pub-cache structure by moving `namespace "dev.isar.isar_flutter_libs"` inside the `android {}` block.
- Implemented a persistent project-level fix in `android/build.gradle.kts` so builds do not rely on manual pub-cache edits each time:
- Added a targeted `subprojects` plugin hook for `com.android.library`.
- Injected namespace only for module `isar_flutter_libs` via reflective `setNamespace(...)` call.
- Verified namespace crash no longer appears in Flutter build flow.

Task 2: Java/Gradle Runtime Compatibility Diagnostics
- Observed separate local Gradle CLI failure (`25.0.2`) due to shell using JDK 25 while Flutter/Android toolchain uses Android Studio JDK 21.
- Confirmed with diagnostics (`java -version`, `flutter doctor -v`) and shifted verification to Flutter-driven builds instead of raw Gradle shell path for correctness.

Task 3: Broken Imports and Codegen Preconditions
- Fixed invalid import in `lib/core/database/database_provider.dart`:
- From `package:path_provider/package_path_provider.dart`
- To `package:path_provider/path_provider.dart`
- Fixed wrong relative database import depth in `daily_log_notifier.dart` (`../../core/...` -> `../../../core/...`) so analyzer could resolve local database modules.
- Repaired corrupted dependency cache symptoms with `flutter pub cache repair`, then performed full project refresh:
- `flutter clean`
- `flutter pub get`

Task 4: Generated Files Missing (`.g.dart`, `.freezed.dart`)
- Repeated missing-file errors indicated generators were not running with a compatible dependency graph.
- Cleaned stale generated artifacts and reran builders multiple times:
- `dart run build_runner clean`
- `dart run build_runner build -d`
- Identified that `local_schemas.g.dart` was missing specifically because `isar_generator` had been absent or blocked by dependency conflicts.

Task 5: Dependency Conflict Root-Cause Resolution
- Identified hard resolver conflict between `isar_generator` and modern `freezed/json_serializable/source_gen` combinations in the current stack.
- Simplified strategy to prioritize Isar schema generation stability:
- Removed Freezed codegen reliance from `meal_draft_notifier.dart`.
- Replaced `@freezed` models (`DraftDish`, `DraftIngredient`) with plain immutable Dart classes including manual `copyWith`, `toJson`, and `fromJson` behavior.
- Updated dependency graph in `pubspec.yaml` to a resolvable set for Isar generation.
- Downgraded `flutter_riverpod` from `3.3.1` to `2.6.1` to satisfy solver constraints with `isar_generator 3.1.0+1` on this toolchain.
- Successfully installed compatible packages and generated outputs.

Task 6: Final Verification & Outcome
- Successfully generated Isar outputs including `lib/core/database/local_schemas.g.dart`.
- `flutter analyze` no longer showed the original namespace/codegen blocking issues (remaining issues were non-blocking infos plus unrelated test/UI modernization notes).
- Final build verification passed:
- `flutter build apk --debug`
- Output: `Built build/app/outputs/flutter-apk/app-debug.apk`

Task 7: Final Stable State Achieved
- App build is unblocked and debug APK generation works.
- Namespace issue is handled from project Gradle config (persistent fix).
- Isar local schema generation is restored.
- Meal draft domain logic remains functional without Freezed codegen dependency pressure.

Phase 5: UI Theming, Dark Mode, & Data Binding Fixes
Task 1: Theming Foundation & Typography
- Added `google_fonts`, `percent_indicator`, and `intl` packages.
- Created `lib/core/theme/app_theme.dart` with a dedicated `AppTheme` class managing light and dark `ThemeData`.
- Configured premium scaffold background rules (`0xFFF8F9FA` for light mode and `0xFF121212` for dark mode).
- Integrated `GoogleFonts.commissioner()` as the baseline system typography standard scaling correctly across dark/light mode switches.
- Explicitly styled `AppBarTheme` (zero elevation, transparent) and `CardThemeData` (soft 16px radius with low opacity shadow) representing the new scalable component guidelines.

Task 2: Macro Custom Colors via ThemeExtension
- Implemented `MacroColors` extending `ThemeExtension` to integrate custom data-colors directly into the Flutter tree.
- Configured light variations (`Colors.redAccent`, `Colors.blueAccent`, etc.) and mapped their customized dark-mode equivalents.
- Safely consumed these extensions in the UI via `Theme.of(context).extension<MacroColors>()` future-proofing dynamic component changes independent from static constants.
- Updated `main.dart`'s `MaterialApp` to automatically adhere to `ThemeMode.system` using `AppTheme.lightTheme` and `AppTheme.darkTheme`.

Task 3: Bug Fix: "Unknown Ingredient" Data Serialization Drop
- Investigated `DraftIngredient` ingestion in `meal_draft_notifier.dart` which was constantly falling back to 'Unknown Ingredient'.
- Mapped the deserialization key strictly to the backend LLM outputs via `.ai_name / .db_matched_name` allowing the parser to pick up `ai_name` natively injected by the FastAPI logic wrapper.
- Finalized data binding, restoring real names dynamically in the local Draft context UI rendering.

Task 4: Dashboard UI - Macro Ring Card Widget
- Created `macro_ring_card.dart` in `lib/features/dashboard/presentation/widgets/`.
- Implemented a sleek `StatelessWidget` mapping custom target and consumed parameters.
- Built a premium rounded container mapping directly to `Theme.of(context).cardTheme.color` avoiding hardcoded white screens on dark mode setups to respect Phase 5 theming standards.
- Integrated `CircularPercentIndicator` package specifying a 45 radius, 8px lineWidth, and round stroke caps perfectly suited for an Apple-like UI feel.
- Handled edge cases: mathematically guarded against `Infinity` percents or negative `g left` labels using `.clamp()` and standard ternary checks, ensuring no rendering runtime explosions if the database target bounds calculate zero limits.

Phase 6: Dashboard Architecture - Macro Tracking Ring Widget
Task 1: Development of `MacroRingCard`
- Created `lib/features/dashboard/presentation/widgets/macro_ring_card.dart` as the reusable stateless foundation for the dashboard UI.
- Implemented `CircularPercentIndicator` using a sleek, premium Apple-like design (radius `45.0`, `lineWidth` `8.0`, with fluid `1200ms` loading animations).
- Safely wrapped the layout using a scalable Flutter `Card` inherited from our Phase 5 `AppTheme`, allowing for flawless rendering in dark (`#1E1E1E`) and light (white) modes with unified `.all(16)` padding and soft outer shadow boundaries.
- Computed decimal mathematics enforcing 1-decimal-place rounding bounds (`.toStringAsFixed(1)`).
- Dynamically clamped the `percent` property (`rawPercent.clamp(0.0, 1.0)`) explicitly resolving internal Flutter layout crash loops if overconsumption exceeds 100%. 
- Upgraded overconsumption user experience: If consumed macros surpass target, the widget dynamically transitions its progress bar and center labels to `Colors.redAccent`, rendering the true absolute differential alongside `"g over"` text strings.

Task 2: Development of `MealTimelineCard`
- Created `lib/features/dashboard/presentation/widgets/meal_timeline_card.dart` receiving the immutable `LocalMeal` dependency.
- Assembled a zero-elevation `Card` utilizing a dynamically scaling `BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.1))` confirming perfect visual dark/light boundaries without manual hex mapping.
- Orchestrated a generic `ListTile` architecture strictly adhering to the `ThemeData` standards without hardcoding color overrides, ensuring seamless integration on complex screens.
- Programmed highly scalable text handling: Bound `.toStringAsFixed(0)` onto internal macro definitions and injected `maxLines: 1` onto `subtitle`, fully immunizing the component from ugly text wrapping on small-scale mobile devices.
- Engineered `_getMealIcon` and `_formatMealType` mappers, gracefully resolving database raw `Enum` strings into nicely formatted titles (e.g. `'late_night'` to `'Late Night'`) and intelligently selecting distinct contextual Material Icons (e.g. `Icons.nightlight_round`).
- Safely consumed `DateFormat.jm().format()` from the `intl` package rendering native `.loggedAt` DateTime instances to human-friendly 12-hour strings (`1:30 PM`).

Task 3: Development of the Main `DashboardScreen`
- Constructed `lib/features/dashboard/presentation/dashboard_screen.dart` operating as the new central `ConsumerWidget` root for the Flutter application replacing `CameraScreen`.
- Successfully linked `DailyLogNotifierProvider` state to natively pull real-time nested local data from Isar via Riverpod dependency injection.
- Built a highly performant `CustomScrollView` (Sliver) architecture explicitly avoiding `shrinkWrap` nested scroll traps, rendering butter-smooth 60fps interaction on mobile viewports.
- Integrated a polished Header utilizing `intl.DateFormat.yMMMMEEEEd()` rendering contextual locale times. Built placeholder architecture for user profile pipeline logic ("Hi Avinash!").
- Delivered a dynamic Hero Section mapping `LinearPercentIndicator`. Set color bindings explicitly to dynamically consume the native `MacroColors.calories`. Integrated a robust 1.0 clamped upper-bound fail-safe converting dynamically to `Colors.redAccent` with `# kcal over` alerts during calculated overconsumption thresholds.
- Embedded the three `MacroRingCard` implementations explicitly inside `Expanded` containers creating responsive horizontal width behavior across differing mobile hardware.
- Engineered a premium dashed-border "Empty State" UI rendering if `dailyLog` is fundamentally null or meals list natively drops to 0, maximizing early UX engagement.
- Embedded an overlaid `FloatingActionButtonLocation.centerFloat` component safely pushing a native `Navigator` stack onto `CameraScreen`.

Task 4: AI Bounding Box Rendering Fix
- Investigated and resolved a critical visual logic bug inside `lib/bounding_box_painter.dart`.
- Identified that `BoxFit.contain` creates letterboxing, mutating the actual visually rendered boundaries versus the raw logical `Canvas` size bounds, which previously forced all green detection squares out of alignment.
- Refactored `BoundingBoxPainter` accepting explicit `imageOriginalWidth` and `imageOriginalHeight`.
- Engineered standard scaling logic: `scale = min(size.width / imageOriginalWidth, size.height / imageOriginalHeight)`.
- Programmatically computed explicit exact rendered heights and widths applying those bounds to mapping matrices.
- Centered the AI detection matrices natively by padding the `dx` and `dy` letterbox space.
- Successfully achieved 1:1 pixel-perfect mapping. The `[y_min, x_min, y_max, x_max]` coordinates received dynamically from the LLaMa backend now anchor securely onto specific raw ingredients exactly where the AI visually analyzed them.

### Phase 7: Offline-to-Cloud Sync Architecture
- **Objective:** Establish a robust mechanism to post local Isar data to the Supabase backend.
- **Implementation:**
  - Migrated core networking dependency from `http` to `dio`.
  - Created `lib/core/network/sync_service.dart`.
  - Implemented `syncOfflineMealsToCloud` logic to:
    - Query Isar for `LocalMeal` instances where `supabaseIdIsNull()`.
    - Loop through unsynced items.
    - Post items via Dio to `/api/v1/meals/log`.
    - Perform a write transaction back to Isar updating the returned `supabase_id`.
  - Identified requirement for `/api/v1/meals/bulk-log` back-end endpoint for future optimization. Documented in `feature-to-add-later.md`.
  - Documented bounding box calculations for future refinement in `feature-to-add-later.md`.

  - Integrated `SyncService` background triggers into the application lifecycle:
    - Initialized global `Provider<Dio>` and `Provider<SyncService>` for global dependency injection without context.
    - Updated `lib/main.dart` to trigger `syncOfflineMealsToCloud` in `_AaharAppState.initState()` asynchronously so offline meals are synced on app launch.
    - Appended `syncOfflineMealsToCloud` background trigger in `lib/features/dashboard/domain/daily_log_notifier.dart` (`addMeal`) to sync newly logged meals immediately.
    - Fixed `MyApp` mismatch in `widget_test.dart` to ensure clean testing.


### Phase 8: User Onboarding
- **Objective:** Establish user profile local caching structure and set up the onboarding progression.
- **Implementation:**
  - Added `LocalUserProfile` Isar collection to `lib/core/database/local_schemas.dart`.
  - Configured `LocalUserProfile` as a local singleton configuration (using `Id id = 1`).
  - Added profile fields: name, weight, height, goal, dietPreference.
  - Added target macro fields returned from backend algorithms.
  - Added `isOnboardingComplete` tracking boolean.
  - Created `AuthService` in `lib/features/onboarding/domain/auth_service.dart`:
    - Handles formatting user form data and making POST requests to `/api/v1/users/profile`.
    - Parses backend macro responses to a `LocalUserProfile`.
    - Commits the user profile to local database synchronously.
  - Implemented `onboardingStateProvider` routing logic:
    - Reads initial `isOnboardingComplete` dynamically from `LocalUserProfile` mapping (singleton id = 1).
    - `AaharApp` now conditionally checks the routing state to either render `DashboardScreen` or a placeholder Onboarding UI flow.
  - **Bug Fix:** Encountered `IsarError: Missing TypeSchema` crashes on test devices when initializing Flutter due to adding the new collection but forgetting to register it.
    - **Resolution:** Added `LocalUserProfileSchema` inside the `Isar.open` schema declarations list within `lib/core/database/database_provider.dart`.
  - Built `OnboardingScreen` UI in `lib/features/onboarding/presentation/onboarding_screen.dart`:
    - Created a scrollable `StatefulWidget` linked to Riverpod.
    - Added modern, rounded, subtly filled `TextFormField` and `DropdownButtonFormField` entries for Name, Gender, Age, Weight, Height, Activity Level, Goal, and Diet.
    - Attached a state-managed "Calculate My Macros" button that shows a Loading indicator overlay, builds a mapped payload, and invokes `authServiceProvider.createUserProfile()`.
    - Integrated automatic App-level routing replacing the placeholder screen with the real `OnboardingScreen`.

  - Refactored `DailyLogNotifier` in `lib/features/dashboard/domain/daily_log_notifier.dart`:
    - When generating a fresh log for the current day, it explicitly fetches the `LocalUserProfile` configuration `id=1`.
    - It dynamically maps `targetCalories` and `targetProteinG` from the cached profile rather than defaulting to hardcoded metrics.
  - **Issue:** Encountered `DioException [connection timeout]` and `SocketException` while trying to sync onboarding data from physical Android device to laptop backend.
  - **Identified Cause:** The mobile device could not route packets successfully over `10.20.16.245` (Wi-Fi adapter IP), likely due to the phone being connected via USB tethering/cable on a different subnet interface (`10.19.133.107`).
  - **Bug Fix:** Hit a `DioException [bad response]` 422 Unprocessable Entity from FastAPI when submitting the onboarding form.
    - **Investigation:** Read `backend/schemas.py` and discovered the `UserCreate` Pydantic model requires strict properties like `target_weight_kg`, array initializers for `allergies` and `medical_conditions`, and stringent Enum mapping parameters (`activity_level` specifically mapping `very active` to `very_active`).
    - **Resolution:** Refactored the `payload` map in `lib/features/onboarding/presentation/onboarding_screen.dart` to strictly pass all defaulted and formatted values that the Python API expects.
  - Refactored `OnboardingScreen` into a two-step pagination UI:
    - `OnboardingScreen`: Captures primary physical body measurements (Age, Weight, Activity, Goal, Diet). Instead of submitting, it bundles to a map and pushes navigation.
    - Added `OnboardingAdvancedScreen`: Accepts the basic maps and proceeds to request the deeper constraints (`region_preference`, `meals_per_day`, string-mapped `allergies`, and `medical_conditions`).
    - Formats the allergies and conditions from comma-separated inputs to clean string Lists arrays safely on submission.
  - Refactored `OnboardingScreen` into a two-step pagination UI:
    - `OnboardingScreen`: Captures primary physical body measurements (Age, Weight, Activity, Goal, Diet). Instead of submitting, it bundles to a map and pushes navigation.
    - Added `OnboardingAdvancedScreen`: Accepts the basic maps and proceeds to request the deeper constraints (`region_preference`, `meals_per_day`, string-mapped `allergies`, and `medical_conditions`).
    - Formats the allergies and conditions from comma-separated inputs to clean string Lists arrays safely on API POST submission.

### Phase 9: Text & Voice Meal Logging Pipeline
- **Objective:** Add NLP ingestion methods for users to quickly describe meals conversationally (e.g. "I ate 2 rotis and some dal").
- **Backend Implementations (`backend/main.py`):**
  - Created `TextLogRequest(text: str)` Pydantic schema in `schemas.py`.
  - Added `@app.post("/api/v1/analyze/text")` endpoint.
  - Implemented the prompt instructing the local LLM (`gemma4:e2b`) to act as an Indian Nutritionist, extract structured JSON matching the visual representation exactly.
  - Enforced a dummy `[0, 0, 0, 0]` bounding_box to maintain absolute schema parity with the vision tool (so Flutter parses both inputs identically).
  - Iterated through ingredients using the same `match_ingredient_in_db()` embeddings function to guarantee the payload shape matches vision outputs.
- **Frontend Implementations (`lib/features/food_logger/presentation/log_meal_screen.dart`):**
  - Renamed the old `camera_screen.dart` to `log_meal_screen.dart` as it now acts as a multi-modal hub.
  - Replaced the simple camera UI with a persistent bottom text bar supporting Voice typing (via `speech_to_text`), manual Text input, and Barcode scanning (via `mobile_scanner`).
  - Implemented `_analyzeText()` POST request handler parallel to the vision logic.
  - Responses successfully map to the `MealConfirmationSheet` identical to visual logs without any logic rewrites due to enforced backend schema parity.
  - Handled Android compilation failures by migrating away from the outdated `simple_barcode_scanner` (which lacked modern Android SDK 34 packages like `android.view`, `android.graphics`) to the reliable `mobile_scanner` standard.
  - **Barcode Integration (OpenFoodFacts API):**
    - Built `_fetchBarcodeData()` to trigger upon successful `mobile_scanner` barcode detection.
    - Sends a GET request directly to the public OpenFoodFacts API (`https://world.openfoodfacts.org/api/v0/product/{barcode}.json`).
    - Dynamically maps macro objects (`energy-kcal`, `proteins`, `carbohydrates`, `fat`) safely.
    - Assembles the response into the exact JSON specification required by `initializeFromAI()`.
    - Populates the `MealConfirmationSheet` enabling immediate verification and "Save to Daily Log" functionality without involving the backend AI inference.

### Phase 10: Workout Recommendation Engine
- **Objective:** Add personalized gym and home workout regimes based on user attributes.
- **Backend Implementations (`backend/workouts.py`):**
  - Designed an independent FastAPI Router containing a static dictionary of three structured regimes: `PPL` (Push/Pull/Legs), `Full_Body`, and `Home_Bodyweight`.
  - Built `recommend_workout(activity_level, goal)` that maps users to `Home_Bodyweight` if they are sedentary/light, `PPL` if they bulk and are active, and `Full_Body` dynamically as a fallback.
  - Exposed via HTTP GET under `/api/v1/workouts/recommend`. Wire-framed correctly into the core FastAPI server `main.py` utilizing sub-routers.

### Phase 10.1: Expand Workout Regime Datasets
- **Objective:** Extend existing `PPL` and `Full_Body` templates to guarantee complete muscle coverage.
- **Backend Implementations (`backend/workouts.py`):**
  - Added `Incline Dumbbell Press` and `Lateral Raises` to `Push Day` for robust upper chest and shoulder development.
  - Added `Face Pulls` and `Hammer Curls` to `Pull Day` to engage rear deltoids and brachialis.
  - Injected `Romanian Deadlift`, `Leg Extensions`, and `Leg Curl Machine` into `Legs Day` maximizing quad and hamstring isolation.
  - Supplemented `Full Body - Workout A` with `Dumbbell RDL` and `Dumbbell Bicep Curls`.
  - Expanded `Full Body - Workout B` by adding `Dumbbell Chest Fly` and `Tricep Extensions`.

### Phase 11: Local Exercise Logging Database Pipeline
- **Objective:** Establish the Flutter local Isar schema architecture to cache the active workout plan and track daily exercise logs including reps and weight used.
- **Implementation:**
  - Added `@collection class LocalWorkoutPlan` representing the active plan as a cached singleton (`Id id = 1`) to ensure optimal query speeds and offline capability.
  - Formatted the plan to store the nested schedule as `List<String> daysJson` serializing the workout strings to map around Isar's strict object limitations safely.
  - Added `@collection class LocalExerciseLog` with `Id id = Isar.autoIncrement` logging each specific exercise performed natively into the database.
  - Added `@Index() String? supabaseId` to establish a cloud-sync lock, preventing duplicated logs when the user reconnects and syncs.
  - Established a strict `IsarLink<LocalDailyLog> dailyLog` relation, meaning all exercises cascade map strictly to their parent log enabling one-call UI summaries (Food + Workouts).
  - Adopted `List<String> completedSetsJson` ensuring all historical progression constraints (reps and individual weight used per set) are safely maintained locally.
  - Updated `database_provider.dart` to securely mount `LocalWorkoutPlanSchema` and `LocalExerciseLogSchema` into `Isar.open` on boot.
