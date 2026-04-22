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
