import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database_provider.dart';
import '../database/local_schemas.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final syncServiceProvider = Provider<SyncService>((ref) {
  final isar = ref.watch(databaseProvider);
  final dio = ref.watch(dioProvider);
  return SyncService(
    isar: isar,
    dio: dio,
    // Default localhost path. Use 10.0.2.2 for Android emulators if needed.
    baseUrl: const String.fromEnvironment('API_URL', defaultValue: 'http://127.0.0.1:8000'),
  );
});

class SyncService {
  final Isar isar;
  final Dio dio;
  final String baseUrl;

  SyncService({
    required this.isar,
    required this.dio,
    required this.baseUrl,
  });

  /// Synchronizes all offline meals asynchronously to the Cloud database.
  /// Aborts gracefully if network connectivity is disabled or unreachable.
  Future<void> syncOfflineMealsToCloud() async {
    try {
      // 1. Identify Unsynced Meals Using the Single Source of Truth
      // We look directly for missing Cloud UUIDs rather than relying on boolean sync flags.
      final unsyncedMeals = await isar.localMeals.filter().supabaseIdIsNull().findAll();

      if (unsyncedMeals.isEmpty) {
        // Nothing to sync
        return;
      }

      print('SyncService: Found ${unsyncedMeals.length} unsynced meals. Starting synchronization...');

      // Fetch User Profile to get real user_id
      final profile = await isar.localUserProfiles.get(1);
      final userId = profile?.userId;
      
      if (userId == null) {
        print('SyncService: Missing User ID. Cannot sync meals.');
        return;
      }

      // 2. Loop through and execute transactional API updates
      for (final meal in unsyncedMeals) {
        try {
          // Construct precise JSON matching Python MealLogRequest Pydantic Schema
          final payload = {
            "user_id": userId,
            "log_date": meal.loggedAt.toIso8601String().split('T')[0], // Map exactly to date YYYY-MM-DD
            "meal_type": meal.mealType,
            "meal_calories": meal.calories,
            "meal_protein_g": meal.protein,
            "meal_carbs_g": meal.carbs,
            "meal_fats_g": meal.fats,
            "meal_fiber_g": 0.0,
            "meal_sugar_g": 0.0,
            "meal_sodium_mg": 0.0,
          };

          // 3. Dispatch POST Request
          final response = await dio.post(
            '$baseUrl/api/v1/meals/log',
            data: payload,
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            // 4. Capture the newly generated cloud UUID
            final responseData = response.data;
            
            // Depending exactly on the Python Response Model (MealLogSuccessResponse or DailyLogResponse), 
            // we safely extract the returned id.
            String? newSupabaseId;
            if (responseData != null) {
              if (responseData['meal_log_response'] != null && responseData['meal_log_response']['id'] != null) {
                 newSupabaseId = responseData['meal_log_response']['id'].toString();
              } else if (responseData['id'] != null) {
                 newSupabaseId = responseData['id'].toString();
              }
            }

            // 5. Commit Cloud UUID to Local Database securely
            if (newSupabaseId != null) {
              await isar.writeTxn(() async {
                meal.supabaseId = newSupabaseId;
                await isar.localMeals.put(meal);
              });
              print('SyncService: Successfully synced meal ${meal.id} -> Cloud ID: $newSupabaseId');
            }
          }
        } catch (e) {
          // Gracefully suppress singular meal failures (e.g. server validation errors)
          // Allows subsequent offline meals to continue attempting sync 
          print('SyncService Error: Failed to sync specific meal ${meal.id}: $e');
        }
      }
    } catch (e) {
      // Graceful absolute abort for network constraints (SocketException, Offline bounds)
      print('SyncService Network Drop: Aborting sync loop safely. Payload: $e');
    }
  }

  /// Synchronizes all offline workouts asynchronously to the Cloud database.
  Future<void> syncOfflineWorkoutsToCloud() async {
    try {
      // 1. Identify Unsynced Workouts
      final unsyncedLogs = await isar.localExerciseLogs.filter().supabaseIdIsNull().findAll();

      if (unsyncedLogs.isEmpty) {
        return;
      }

      print('SyncService: Found ${unsyncedLogs.length} unsynced workouts. Starting synchronization...');

      // Fetch User Profile to get real user_id
      final profile = await isar.localUserProfiles.get(1);
      final userId = profile?.userId;
      
      if (userId == null) {
        print('SyncService: Missing User ID. Cannot sync workouts.');
        return;
      }

      // 2. Format Payload
      final List<Map<String, dynamic>> logsPayload = [];
      for (final log in unsyncedLogs) {
        final decodedSets = log.completedSetsJson.map((e) => jsonDecode(e)).toList();
        
        logsPayload.add({
          "user_id": userId,
          "date": log.date.toIso8601String().split('T')[0],
          "exercise_name": log.exerciseName ?? "Unknown Exercise",
          "sets_completed": decodedSets.length,
          "target_sets": log.targetSets > 0 ? log.targetSets : 1, // Fallback if 0
          "completed_sets_json": decodedSets,
        });
      }

      final payload = {"logs": logsPayload};

      // 3. Dispatch POST Request
      final response = await dio.post(
        '$baseUrl/api/v1/workouts/log',
        data: payload,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data['data'] as List<dynamic>?;
        
        await isar.writeTxn(() async {
          for (final log in unsyncedLogs) {
             log.isSyncedWithCloud = true;
             
             if (responseData != null) {
               // Find the corresponding inserted log to extract the uuid
               final matched = responseData.firstWhere(
                 (e) => e['exercise_name'] == log.exerciseName && e['date'] == log.date.toIso8601String().split('T')[0],
                 orElse: () => null,
               );
               if (matched != null) {
                 log.supabaseId = matched['id'] as String?;
               }
             }
             
             // If the backend didn't return an ID for some reason but it succeeded, 
             // we still save it to prevent infinite sync loops. If we need strict 
             // UUID checks, we'd assign a fake one or throw, but here we trust the 200 OK.
             if (log.supabaseId == null) {
                log.supabaseId = 'synced_offline_${DateTime.now().millisecondsSinceEpoch}';
             }

             await isar.localExerciseLogs.put(log);
          }
        });
        print('SyncService: Successfully synced ${unsyncedLogs.length} workouts.');
      }
    } catch (e) {
      print('SyncService Workout Error: Failed to sync workouts: $e');
    }
  }
}
