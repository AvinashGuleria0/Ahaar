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

      // 2. Loop through and execute transactional API updates
      for (final meal in unsyncedMeals) {
        try {
          // Construct precise JSON matching Python MealLogRequest Pydantic Schema
          final payload = {
            "user_id": "123e4567-e89b-12d3-a456-426614174000", // Current Mock ID representing the Authorized User
            "log_date": meal.loggedAt.toIso8601String(),
            "meal_type": meal.mealType,
            "meal_cals": meal.calories,
            "meal_protein": meal.protein,
            "meal_carbs": meal.carbs,
            "meal_fats": meal.fats,
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
}
