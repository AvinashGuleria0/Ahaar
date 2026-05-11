import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/local_schemas.dart';
import '../../../core/network/sync_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioProvider);
  final isar = ref.watch(databaseProvider);
  return AuthService(
    dio: dio,
    isar: isar,
    baseUrl: const String.fromEnvironment('API_URL', defaultValue: 'http://127.0.0.1:8000'),
    ref: ref,
  );
});

class AuthService {
  final Dio dio;
  final Isar isar;
  final String baseUrl;
  final Ref ref;

  AuthService({
    required this.dio,
    required this.isar,
    required this.baseUrl,
    required this.ref,
  });

  /// Submits the initial user profile attributes to the backend algorithm.
  /// Receives the configured macro guidelines and caches the profile locally.
  Future<void> createUserProfile(Map<String, dynamic> userData) async {
    try {
      // 1. If we have a cached profile with an existing user_id, we shouldn't create a new one but rather update.
      // But since this is createUserProfile, we will send the payload without user_id, 
      // or if we must send a mock, we don't, because the backend UserCreate doesn't expect user_id.
      // Looking at `UserCreate` in `backend/schemas.py`, it does not require `user_id`.
      final payload = {
        ...userData,
      };

      // 2. Perform API POST Request
      final response = await dio.post(
        '$baseUrl/api/v1/users/profile',
        data: payload,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        
        // Safety parsing, as some backends wrap inside 'profile' key
        final targets = data['profile'] ?? data;

        // 3. Assemble Local Configuration Document
        final profile = LocalUserProfile()
          ..id = 1
          ..userId = (targets['id'] as String?) // Backend returns 'id' (UUID)
          ..authId = (targets['auth_id'] as String?)
          ..name = userData['name'] as String?
          ..weightKg = (userData['weight_kg'] as num?)?.toDouble()
          ..heightCm = (userData['height_cm'] as num?)?.toDouble()
          ..goal = userData['goal'] as String?
          ..dietPreference = userData['diet_preference'] as String?
          // Fallbacks in case formatting doesn't directly map
          ..targetCalories = (targets['target_calories'] as num?)?.toInt() ?? 2000
          ..targetProteinG = (targets['target_protein_g'] as num?)?.toInt() ?? 120
          ..targetCarbsG = (targets['target_carbs_g'] as num?)?.toInt() ?? 250
          ..targetFatsG = (targets['target_fats_g'] as num?)?.toInt() ?? 60
          ..targetWaterMl = (targets['target_water_ml'] as num?)?.toInt() ?? 2500
          ..isOnboardingComplete = true;

        // 4. Synchronously write the completed state into local storage 
        await isar.writeTxn(() async {
          await isar.localUserProfiles.put(profile);
        });
        
        // 5. Update the routing state hook
        ref.read(onboardingStateProvider.notifier).state = true;

        print('AuthService: Profile cached successfully and Onboarding is Complete.');
      } else {
        throw Exception('Failed to finalize profile synchronization.');
      }
    } catch (e) {
      print('AuthService Error during user onboarding request: $e');
      rethrow;
    }
  }

  /// Updates the user's weight dynamically, fetching recalculated macros if applicable.
  /// Returns [true] if the weight change triggered a macro update, [false] otherwise.
  Future<bool> updateUserWeight(double newWeightKg) async {
    try {
      final profile = isar.localUserProfiles.getSync(1);
      final String? userId = profile?.userId;
      
      if (userId == null) {
        throw Exception('User ID is missing from local profile. Cannot update weight on backend.');
      }
      
      // 1. Perform API PATCH Request (Query Param user_id + Body payload)
      final response = await dio.patch(
        '$baseUrl/api/v1/users/profile/weight?user_id=$userId',
        data: {'weight_kg': newWeightKg},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        
        // Safety parsing
        final targets = data['profile'] ?? data;

        // 2. Open synchronous write transaction to Isar
        bool didMacrosChange = false;
        
        isar.writeTxnSync(() {
          final profile = isar.localUserProfiles.getSync(1);
          if (profile != null) {
            profile.weightKg = newWeightKg;
            
            // Check if targetCalories shifted to fire the SnackBar notification
            final newCalories = (targets['target_calories'] as num?)?.toInt();
            if (newCalories != null && profile.targetCalories != newCalories) {
              didMacrosChange = true;
              
              profile.targetCalories = newCalories;
              profile.targetProteinG = (targets['target_protein_g'] as num?)?.toInt() ?? profile.targetProteinG;
              profile.targetCarbsG = (targets['target_carbs_g'] as num?)?.toInt() ?? profile.targetCarbsG;
              profile.targetFatsG = (targets['target_fats_g'] as num?)?.toInt() ?? profile.targetFatsG;
              profile.targetWaterMl = (targets['target_water_ml'] as num?)?.toInt() ?? profile.targetWaterMl;
            }
            
            isar.localUserProfiles.putSync(profile);
          }
        });

        print('AuthService: Weight updated. Macros changed: $didMacrosChange');
        return didMacrosChange;
      } else {
        throw Exception('Failed to update weight on server.');
      }
    } on DioException catch (e) {
      // 3. Offline fallback
      print('AuthService Offline Fallback: Saving weight locally. Error: $e');
      
      isar.writeTxnSync(() {
        final profile = isar.localUserProfiles.getSync(1);
        if (profile != null) {
          profile.weightKg = newWeightKg;
          isar.localUserProfiles.putSync(profile);
        }
      });
      return false; // Macros definitely didn't change offline
    } catch (e) {
      print('AuthService Error during weight update: $e');
      rethrow;
    }
  }
}

/// Global provider to track whether the user has completed onboarding and can access the Dashboard.
final onboardingStateProvider = StateProvider<bool>((ref) {
  // Sync read from Isar upon initial provider build
  final isar = ref.read(databaseProvider);
  final profile = isar.localUserProfiles.getSync(1);
  return profile?.isOnboardingComplete ?? false;
});
