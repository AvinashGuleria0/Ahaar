  /// Updates the user's weight dynamically, fetching recalculated macros if applicable.
  /// Returns [true] if the weight change triggered a macro update, [false] otherwise.
  Future<bool> updateUserWeight(double newWeightKg) async {
    try {
      final String mockUserId = "123e4567-e89b-12d3-a456-426614174000";
      
      // 1. Perform API PATCH Request (Query Param user_id + Body payload)
      final response = await dio.patch(
        '$baseUrl/api/v1/users/profile/weight?user_id=$mockUserId',
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
