import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/database_provider.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'core/theme/app_theme.dart';

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
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const DashboardScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}