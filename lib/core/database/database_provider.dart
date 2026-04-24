import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'local_schemas.dart';

/// Exposes the active Isar local database instance globally to all Riverpod Notifiers.
final databaseProvider = Provider<Isar>((ref) {
  throw UnimplementedError('databaseProvider must be overridden in providerScope');
});

/// A utility to properly initialize Isar during app startup (main.dart).
class DatabaseService {
  static Future<Isar> init() async {
    final dir = await path_provider.getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [LocalDailyLogSchema, LocalMealSchema],
      directory: dir.path,
    );
    return isar;
  }
}