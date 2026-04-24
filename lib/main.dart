import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/database_provider.dart';
import 'core/network/sync_service.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/onboarding/domain/auth_service.dart';
import 'features/onboarding/presentation/onboarding_screen.dart';
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
      child: const AaharApp(),
    ),
  );
}

class AaharApp extends ConsumerStatefulWidget {
  const AaharApp({super.key});

  @override
  ConsumerState<AaharApp> createState() => _AaharAppState();
}

class _AaharAppState extends ConsumerState<AaharApp> {
  @override
  void initState() {
    super.initState();
    // Trigger syncOfflineMealsToCloud in the background right after initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(syncServiceProvider).syncOfflineMealsToCloud().ignore();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dynamically watch the global routing state
    final isOnboardingComplete = ref.watch(onboardingStateProvider);

    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: isOnboardingComplete 
          ? const DashboardScreen() 
          : const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

