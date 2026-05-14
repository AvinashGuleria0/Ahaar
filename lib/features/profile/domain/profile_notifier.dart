import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/local_schemas.dart';

/// Provides a reactive stream of the singleton user profile from Isar.
/// Any updates from the backend (like new weights triggering macro recalculations)
/// will instantly stream to the UI without manual rebuild checks.
final userProfileStreamProvider = StreamProvider<LocalUserProfile?>((ref) {
  final isar = ref.watch(databaseProvider);
  return isar.localUserProfiles.watchObject(1, fireImmediately: true);
});
