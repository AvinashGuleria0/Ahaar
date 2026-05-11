import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/database/database_provider.dart';
import '../../onboarding/domain/auth_service.dart';
import '../../dashboard/domain/daily_log_notifier.dart';
import '../domain/profile_notifier.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController _weightController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _updateWeight() async {
    final text = _weightController.text;
    final weight = double.tryParse(text);

    // 1. Local Validation Bounds
    if (weight == null || weight <= 20 || weight >= 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid format. Please enter a valid weight (kg) between 20 and 300.")
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 2. Transmit to backend & Local Database Cache
      final didMacrosChange = await ref.read(authServiceProvider).updateUserWeight(weight);
      
      // 3. Immediately queue Dashboard Ring refresh targeting today's date bounds
      ref.read(dailyLogProvider.notifier).refreshTargetsFromProfile();
      
      if (!mounted) return;
      _weightController.clear();
      
      // 4. Contextual UI Notifications based on the Smart Boolean Thresholds
      final message = didMacrosChange
          ? "Weight logged! Your daily calorie targets have been adjusted."
          : "Weight logged successfully!";
          
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      
      // Note: The Riverpod StreamProvider automatically repaints the Profile Screen!
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Server integration failed: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
  
  /// Wipes all local Isar collections tracking data natively and returns to the initial Onboarding flow.
  Future<void> _logoutAndResetApp() async {
    final isar = ref.read(databaseProvider);
    await isar.writeTxn(() async {
      await isar.clear(); // Absolute persistent memory wipe covering Logs, Meals, Profile Configs, etc.
    });

    // Directly mutate routing provider resolving `AaharApp()` root cascade natively removing auth contexts.
    ref.read(onboardingStateProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(userProfileStreamProvider);
    final macroColors = Theme.of(context).extension<MacroColors>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: 'Reset App',
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Reset App Data"),
                  content: const Text("Are you sure you want to permanently delete all local logs and log out?"),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _logoutAndResetApp();
                      },
                      child: const Text("Logout & Reset", style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              );
            }
          )
        ],
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) return const Center(child: Text("Missing Profile context"));

          // Capitalize names safely
          final displayName = (profile.name ?? 'User').toUpperCase();
          final displayGoal = (profile.goal ?? 'Maintenance').toUpperCase();
          final weightStr = profile.weightKg?.toStringAsFixed(1) ?? '--';

          return RefreshIndicator(
            onRefresh: () async {}, // Place holder for future cloud syncing operations
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- HERO SECTION ---
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            child: Icon(Icons.person_pin, size: 40, color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(height: 16),
                          Text(displayName, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text("Goal: $displayGoal", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey)),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.monitor_weight_outlined, size: 24),
                              const SizedBox(width: 8),
                              Text("$weightStr kg", style: Theme.of(context).textTheme.headlineMedium),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- LOG NEW WEIGHT ---
                  Text("Log New Weight", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _weightController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Weight (kg)',
                            hintText: 'e.g. 75.5',
                            prefixIcon: Icon(Icons.scale),
                          ),
                          onSubmitted: (_) => _updateWeight(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        height: 56, // Match height of standard textfield bounds
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _updateWeight,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: _isLoading 
                            ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text("UPDATE"),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // --- CURRENT MACRO TARGETS ---
                  Text("Daily Targets", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      _buildMacroTile("Calories", "${profile.targetCalories ?? '--'} kcal", macroColors?.calories ?? Colors.teal),
                      _buildMacroTile("Protein", "${profile.targetProteinG ?? '--'} g", macroColors?.protein ?? Colors.redAccent),
                      _buildMacroTile("Carbs", "${profile.targetCarbsG ?? '--'} g", macroColors?.carbs ?? Colors.blueAccent),
                      _buildMacroTile("Fats", "${profile.targetFatsG ?? '--'} g", macroColors?.fats ?? Colors.amber),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text("Profile Stream Error: $e")),
      ),
    );
  }

  Widget _buildMacroTile(String title, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
