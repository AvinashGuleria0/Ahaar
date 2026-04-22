import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/database_provider.dart';
import 'features/food_logger/presentation/camera_screen.dart';

void main() async {
  // Ensure native channel hook is initialized prior to Isar build
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize foundational database engine layer
  final isarInstance = await DatabaseService.init();

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(isarInstance),
      ],
      child: const MaterialApp(
        home: CameraScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}