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
      // 1. Assign the mock authorized user_id and merge userData variables
      final payload = {
        "user_id": "123e4567-e89b-12d3-a456-426614174000",
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
}

/// Global provider to track whether the user has completed onboarding and can access the Dashboard.
final onboardingStateProvider = StateProvider<bool>((ref) {
  // Sync read from Isar upon initial provider build
  final isar = ref.read(databaseProvider);
  final profile = isar.localUserProfiles.getSync(1);
  return profile?.isOnboardingComplete ?? false;
});

