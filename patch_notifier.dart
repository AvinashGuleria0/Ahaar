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

    await isar.writeTxn(() async {
      // Re-assign target limits gracefully parsing explicit integer data
      log.targetCalories = (profile.targetCalories ?? log.targetCalories).toDouble();
      log.targetProtein = (profile.targetProteinG ?? log.targetProtein).toDouble();
      
      await isar.localDailyLogs.put(log);
    });

    // Implicitly triggers the standard Riverpod consumer state cascade, animating the macro rings properly!
    state = AsyncData(log);
  }
