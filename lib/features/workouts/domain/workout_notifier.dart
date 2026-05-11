import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/local_schemas.dart';
import '../../../core/network/sync_service.dart';
import '../../../core/services/notification_service.dart';

// Create a provider for the AsyncNotifier
final workoutNotifierProvider = AsyncNotifierProvider<WorkoutNotifier, LocalWorkoutPlan?>(() {
  return WorkoutNotifier();
});

// Create the StreamProvider for UI Reactivity
final dailyExerciseLogProvider = StreamProvider<List<LocalExerciseLog>>((ref) {
  final isar = ref.watch(databaseProvider);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  
  // Watch today's exercise logs and fire immediately so UI gets data instantly
  return isar.localExerciseLogs.where().dateEqualTo(today).watch(fireImmediately: true);
});

class WorkoutNotifier extends AsyncNotifier<LocalWorkoutPlan?> {
  @override
  Future<LocalWorkoutPlan?> build() async {
    final isar = ref.watch(databaseProvider);
    LocalWorkoutPlan? plan;
    
    // 1. Try to load from Isar cache first
    final localPlan = await isar.localWorkoutPlans.get(1);
    if (localPlan != null) {
      plan = localPlan; // Instantly resolves offline
    } else {
      // 2. Fallback: Fetch from backend and cache
      plan = await _fetchAndCacheWorkoutPlan(isar);
    }
    
    if (plan != null && plan.daysJson.isNotEmpty) {
      // Schedule Gym Reminder Coach
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final logsToday = await isar.localExerciseLogs.where().dateEqualTo(today).findAll();
      
      if (logsToday.isEmpty) {
        final List<Map<String, dynamic>> days = plan.daysJson
            .map((e) => jsonDecode(e) as Map<String, dynamic>)
            .toList();
            
        final routineIndex = (now.weekday - 1) % days.length;
        final currentDay = days[routineIndex];
        final dayName = currentDay['day_name'] as String? ?? 'Workout';
        
        ref.read(notificationServiceProvider).scheduleGymReminder(dayName);
      }
    }
    
    return plan;
  }

  Future<LocalWorkoutPlan?> _fetchAndCacheWorkoutPlan(Isar isar) async {
    try {
      final userProfile = await isar.localUserProfiles.get(1);
      
      // We safely fall back to defaults if properties are missing
      final activityLevel = userProfile?.activityLevel ?? 'active';
      final goal = userProfile?.goal ?? 'maintain';

      final dio = ref.read(dioProvider);
      const baseUrl = String.fromEnvironment('API_URL', defaultValue: 'http://127.0.0.1:8000');
      
      final response = await dio.get(
        '$baseUrl/api/v1/workouts/recommend',
        queryParameters: {
          'activity_level': activityLevel,
          'goal': goal,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        
        final plan = LocalWorkoutPlan()
          ..id = 1
          ..planName = data['name'] as String?;
          
        final schedule = data['schedule'] as List<dynamic>? ?? [];
        plan.daysJson = schedule.map((e) => jsonEncode(e)).toList();

        // 3. Cache into Isar (Single source of truth)
        await isar.writeTxn(() async {
          await isar.localWorkoutPlans.put(plan);
        });

        return plan;
      }
    } catch (e) {
      print('WorkoutNotifier Network Error: $e');
    }
    return null;
  }

  /// Logs a set for a given exercise directly to Isar.
  /// The [dailyExerciseLogProvider] stream will automatically pick this up and update the UI.
  Future<void> logSetComplete(String exerciseName, int reps, double weight, int targetSets) async {
    final isar = ref.read(databaseProvider);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    await isar.writeTxn(() async {
      // 1. Find or create today's DailyLog
      var todayLog = await isar.localDailyLogs.where().logDateEqualTo(today).findFirst();
      if (todayLog == null) {
        todayLog = LocalDailyLog()..logDate = today;
        await isar.localDailyLogs.put(todayLog);
      }

      // 2. Find or create the ExerciseLog for this specific exercise today
      var exerciseLog = await isar.localExerciseLogs
          .where()
          .dateEqualTo(today)
          .filter()
          .exerciseNameEqualTo(exerciseName)
          .findFirst();

      if (exerciseLog == null) {
        exerciseLog = LocalExerciseLog()
          ..date = today
          ..exerciseName = exerciseName
          ..targetSets = targetSets;
        // Need to put it into Isar first to generate the auto-increment ID before saving links
        await isar.localExerciseLogs.put(exerciseLog); 
        exerciseLog.dailyLog.value = todayLog;
        await exerciseLog.dailyLog.save();
      }

      // 3. Append the new set
      final newSet = jsonEncode({'reps': reps, 'weight': weight});
      final updatedSets = List<String>.from(exerciseLog.completedSetsJson)..add(newSet);
      exerciseLog.completedSetsJson = updatedSets;

      // 4. Save updates back to database
      await isar.localExerciseLogs.put(exerciseLog);
    });
  }
}
