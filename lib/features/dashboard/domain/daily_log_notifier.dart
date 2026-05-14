import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/local_schemas.dart';
import '../../../core/network/sync_service.dart';
import '../../../core/services/context_service.dart';

class DailyLogNotifier extends AsyncNotifier<LocalDailyLog?> {
  @override
  Future<LocalDailyLog?> build() async {
    final isar = ref.watch(databaseProvider);

    // Rule: Truncate time to ensure we isolate the precise current day calendar block.
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Query local database
    var log = await isar.localDailyLogs
        .filter()
        .logDateEqualTo(today)
        .findFirst();

    // If zero logs exist for today, initialize a fresh baseline to seed the UI dashboard
    if (log == null) {
      // Look up target macros internally initialized from onboarding.
      final profile = await isar.localUserProfiles.get(1);

      // --- HYDRATION CONTEXT AWARE LOGIC ---
      double dailyWaterTarget = 2.5; // Base default for most adults
      bool heatBoost = false;
      try {
        final contextService = ref.read(contextServiceProvider);
        final weather = await contextService.fetchLocalWeather();
        
        if (weather != null && weather.temperature > 35.0) {
           dailyWaterTarget += 0.5; // Boost by 500ml for extreme heat
           heatBoost = true;
           print('ContextAwareEngine: Heat detected (${weather.temperature}°C). Hydration target increased to $dailyWaterTarget L');
        }
      } catch (e) {
        print("Hydration Context Logic Failed: $e");
      }

      log = LocalDailyLog()
        ..logDate = today
        // Retrieve goals dynamically based on User Profile caching setup
        ..targetCalories = (profile?.targetCalories ?? 2400).toDouble()
        ..targetProtein = (profile?.targetProteinG ?? 140).toDouble()
        ..targetCarbs = (profile?.targetCarbsG ?? 250).toDouble()
        ..targetFats = (profile?.targetFatsG ?? 60).toDouble()
        ..targetWaterLiters = dailyWaterTarget
        ..isHeatBoostActive = heatBoost
        ..isSyncedWithCloud = false;

      // Persist the initialized blank log immediately
      await isar.writeTxn(() async {
        await isar.localDailyLogs.put(log!);
      });
    }

    return log;
  }

  /// Appends macros from a new meal instance to today's core daily log.
  /// Flags synchronization queue natively.
  Future<void> addMeal(LocalMeal meal) async {
    final isar = ref.read(databaseProvider);
    final log = state.value;

    if (log == null) {
      throw Exception("Cannot append meal: Daily log is fundamentally missing from state.");
    }

    // 1. Math computation on current loaded metrics
    log.consumedCalories += meal.calories;
    log.consumedProtein += meal.protein;
    log.consumedCarbs += meal.carbs;
    log.consumedFats += meal.fats;
    
    log.isSyncedWithCloud = false;

    // 2. Transact atomically to disk
    await isar.writeTxn(() async {
      // Refresh log macros
      await isar.localDailyLogs.put(log);
      
      // Inject meal instance
      await isar.localMeals.put(meal);
      
      // Relational mapping (binds parent ID implicitly under Isar guidelines)
      meal.dailyLog.value = log;
      await meal.dailyLog.save();
    });

    // 3. Force rebuild standard UI state 
    state = AsyncData(log);

    // 4. Asynchronously attempt to sync the newly created offline meal to the cloud
    ref.read(syncServiceProvider).syncOfflineMealsToCloud().ignore();
  }
  /// Refreshes today's macro targets dynamically if the user profile was updated (e.g. weight change).
  /// Historical targets (yesterday, etc) are intentionally not altered to preserve past accuracy.
  Future<void> refreshTargetsFromProfile() async {
    final isar = ref.read(databaseProvider);
    final log = state.value;

    if (log == null) return;

    // Rule: Only update if it's strictly TODAY's log
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    if (log.logDate != today) {
      return; // Do not alter historical logs, maintaining visual integrity of past rings.
    }

    final profile = await isar.localUserProfiles.get(1);
    if (profile == null) return;

    // --- HYDRATION CONTEXT AWARE LOGIC ---
    double dailyWaterTarget = 2.5;
    bool heatBoost = false;
    try {
      final contextService = ref.read(contextServiceProvider);
      final weather = await contextService.fetchLocalWeather();
      
      if (weather != null && weather.temperature > 35.0) {
         dailyWaterTarget += 0.5;
         heatBoost = true;
      }
    } catch (e) {
      print("Hydration Context Logic Failed: $e");
    }

    await isar.writeTxn(() async {
      // Re-assign target limits gracefully parsing explicit integer data
      log.targetCalories = (profile.targetCalories ?? log.targetCalories).toDouble();
      log.targetProtein = (profile.targetProteinG ?? log.targetProtein).toDouble();
      log.targetCarbs = (profile.targetCarbsG ?? log.targetCarbs).toDouble();
      log.targetFats = (profile.targetFatsG ?? log.targetFats).toDouble();
      
      // Update water
      log.targetWaterLiters = dailyWaterTarget;
      log.isHeatBoostActive = heatBoost;
      
      await isar.localDailyLogs.put(log);
    });

    // Implicitly triggers the standard Riverpod consumer state cascade, animating the macro rings properly!
    state = AsyncData(log);
  }

  /// Logs a glass of water dynamically.
  Future<void> addWater(double amountLiters) async {
    final isar = ref.read(databaseProvider);
    final log = state.value;
    if (log == null) return;

    log.consumedWaterLiters += amountLiters;
    if (log.consumedWaterLiters < 0) log.consumedWaterLiters = 0; // Guard against negative bounds

    await isar.writeTxn(() async {
      await isar.localDailyLogs.put(log);
    });

    state = AsyncData(log);
  }

}

/// Global provider for UI consumer listeners
final dailyLogProvider = AsyncNotifierProvider<DailyLogNotifier, LocalDailyLog?>(() {
  return DailyLogNotifier();
});
