import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../core/database/local_schemas.dart';
import '../../../core/theme/app_theme.dart';
import '../../food_logger/presentation/log_meal_screen.dart';
import '../domain/daily_log_notifier.dart';
import 'widgets/macro_ring_card.dart';
import 'widgets/meal_timeline_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State Management Observer
    final dailyLogState = ref.watch(dailyLogProvider);

    // Auth Pipeline (Dummy for now, ready for later integration)
    final String greetingName = "Avinash"; 

    final macroColors = Theme.of(context).extension<MacroColors>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: dailyLogState.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.deepOrange)),
        error: (err, stack) => Center(child: Text('Error loading dashboard: $err')),
        data: (dailyLog) {
          // Fallback targets for an uninitialized or empty day 
          // (Can pipe this from a UserProfile provider later)
          final double targetCals = dailyLog?.targetCalories ?? 2500;
          final double targetPro = dailyLog?.targetProtein ?? 150;
          final double targetCarbs = 200; // Hardcoded default for visual phase
          final double targetFats = 70;   // Hardcoded default for visual phase

          // Consumed metrics
          final double consumedCals = dailyLog?.consumedCalories ?? 0.0;
          final double consumedPro = dailyLog?.consumedProtein ?? 0.0;
          final double consumedCarbs = dailyLog?.consumedCarbs ?? 0.0;
          final double consumedFats = dailyLog?.consumedFats ?? 0.0;

          // Calculate overall calorie progress
          final double calDiff = targetCals - consumedCals;
          final bool isOverCals = calDiff < 0;
          final double rawCalPercent = consumedCals / (targetCals > 0 ? targetCals : 1.0);
          final double displayCalPercent = rawCalPercent.clamp(0.0, 1.0);

          final mealsList = dailyLog?.meals.toList() ?? [];

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // 1. HEADER (Greeting & Date)
              SliverToBoxAdapter(
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMMEEEEd().format(DateTime.now()),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Hi $greetingName!',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 2. HERO SECTION (Calories Linear Indicator)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Calories',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                isOverCals 
                                  ? '${calDiff.abs().toStringAsFixed(0)} kcal over' 
                                  : '${calDiff.toStringAsFixed(0)} kcal left',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600, 
                                  fontSize: 14,
                                  color: isOverCals ? Colors.redAccent : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          LinearPercentIndicator(
                            animation: true,
                            animationDuration: 1000,
                            lineHeight: 18.0,
                            padding: EdgeInsets.zero,
                            percent: displayCalPercent,
                            barRadius: const Radius.circular(10),
                            progressColor: isOverCals ? Colors.redAccent : (macroColors?.calories ?? Colors.teal),
                            backgroundColor: (macroColors?.calories ?? Colors.teal).withValues(alpha: 0.15),
                            center: Text(
                              '${consumedCals.toStringAsFixed(0)} / ${targetCals.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // 3. MACRO RINGS ROW
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: MacroRingCard(
                          title: 'Protein',
                          consumed: consumedPro,
                          target: targetPro,
                          progressColor: macroColors?.protein ?? Colors.redAccent,
                        ),
                      ),
                      Expanded(
                        child: MacroRingCard(
                          title: 'Carbs',
                          consumed: consumedCarbs,
                          target: targetCarbs,
                          progressColor: macroColors?.carbs ?? Colors.blueAccent,
                        ),
                      ),
                      Expanded(
                        child: MacroRingCard(
                          title: 'Fats',
                          consumed: consumedFats,
                          target: targetFats,
                          progressColor: macroColors?.fats ?? Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // 4. TIMELINE HEADER
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text(
                    "Today's Meals",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              // 5. MEALS TIMELINE CONTEXT (Empty vs Populated)
              if (mealsList.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color?.withValues(alpha: 0.5) ?? Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            size: 48,
                            color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No meals logged yet.',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap the camera to scan your first meal.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final meal = mealsList[index];
                      // Add padding to bottom of last item so it isn't blocked by FAB
                      final bottomPadding = index == mealsList.length - 1 ? 80.0 : 0.0;
                      return Padding(
                        padding: EdgeInsets.only(bottom: bottomPadding),
                        child: MealTimelineCard(meal: meal),
                      );
                    },
                    childCount: mealsList.length,
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.camera_alt),
        label: const Text(
          'Scan Meal',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onPressed: () {
          // Push strictly onto the navigation stack
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LogMealScreen()),
          );
        },
      ),
    );
  }
}
