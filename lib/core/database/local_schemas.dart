import 'package:isar/isar.dart';

part 'local_schemas.g.dart';

@collection
class LocalDailyLog {
  Id id = Isar.autoIncrement;

  /// The Cloud UUID from Supabase. 
  /// Null if this log was created offline and hasn't been synced to the server yet.
  /// This prevents duplicating logs when the internet reconnects.
  @Index()
  String? supabaseId;

  /// CRITICAL RULE: This DateTime MUST be zeroed out to the exact day.
  /// Example: DateTime(now.year, now.month, now.day)
  /// This ensures we don't accidentally create multiple daily logs for the same day.
  @Index()
  late DateTime logDate;

  // Daily Targets
  double targetCalories = 0.0;
  double targetProtein = 0.0;

  // Running Totals (Consumed)
  double consumedCalories = 0.0;
  double consumedProtein = 0.0;
  double consumedCarbs = 0.0;
  double consumedFats = 0.0;

  // Cloud Sync Status
  bool isSyncedWithCloud = false;

  // Backlink automatically mapping all meals linked to this specific day
  @Backlink(to: 'dailyLog')
  final meals = IsarLinks<LocalMeal>();
}

@collection
class LocalMeal {
  Id id = Isar.autoIncrement;

  /// The Cloud UUID from Supabase. 
  /// Null if this meal was created offline and hasn't been synced yet.
  @Index()
  String? supabaseId;

  /// Matches the backend Enum: 'breakfast', 'lunch', 'snack', 'dinner', 'dessert', 'late_night'
  late String mealType; 
  
  /// The exact timestamp the user logged the meal.
  late DateTime loggedAt;

  // Specific Meal Macros
  double calories = 0.0;
  double protein = 0.0;
  double carbs = 0.0;
  double fats = 0.0;

  // Relationship to the parent Daily Log
  final dailyLog = IsarLink<LocalDailyLog>();
}

@collection
class LocalUserProfile {
  /// Defines a singleton approach by strictly locking the ID to 1.
  /// There is only expected to be one active user profile cached on the device.
  Id id = 1;

  String? name;
  double? weightKg;
  double? heightCm;
  String? goal;
  String? dietPreference;

  // Cached target metrics returned by the remote backend
  int? targetCalories;
  int? targetProteinG;
  int? targetCarbsG;
  int? targetFatsG;
  int? targetWaterMl;

  // Gateway check for skipping onboarding flow
  bool isOnboardingComplete = false;
}

@collection
class LocalWorkoutPlan {
  /// Defines a singleton approach by strictly locking the ID to 1.
  /// This stores the currently active workout plan on the device.
  Id id = 1;

  String? planName;

  /// Storing the daily schedule as serialized JSON to bypass Isar's nested object limitations.
  List<String> daysJson = [];
}

@collection
class LocalExerciseLog {
  Id id = Isar.autoIncrement;

  /// The Cloud UUID from Supabase. 
  /// Null if this log was created offline and hasn't been synced to the server yet.
  @Index()
  String? supabaseId;

  /// The exact day this exercise was performed. Zeroed out for daily queries.
  @Index()
  late DateTime date;

  String? exerciseName;

  /// Tracking exact reps and weight for each set as serialized JSON.
  /// Example: ['{"reps": 10, "weight": 50}', '{"reps": 8, "weight": 55}']
  List<String> completedSetsJson = [];

  // Cloud Sync Status
  bool isSyncedWithCloud = false;

  // Relationship to the parent Daily Log
  final dailyLog = IsarLink<LocalDailyLog>();
}
