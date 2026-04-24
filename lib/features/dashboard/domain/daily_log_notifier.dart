import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/local_schemas.dart';

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
      log = LocalDailyLog()
        ..logDate = today
        // Optionally inherit target calories from previous day here, but defaulted to 0.0 for now
        ..targetCalories = 2400
        ..targetProtein = 140
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
  }
}

/// Global provider for UI consumer listeners
final dailyLogProvider = AsyncNotifierProvider<DailyLogNotifier, LocalDailyLog?>(() {
  return DailyLogNotifier();
});