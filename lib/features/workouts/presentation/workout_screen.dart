import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/workout_notifier.dart';

class WorkoutScreen extends ConsumerStatefulWidget {
  const WorkoutScreen({super.key});

  @override
  ConsumerState<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
  int _selectedDayOfWeek = 0;

  @override
  void initState() {
    super.initState();
    // DateTime.weekday returns 1 (Monday) to 7 (Sunday). Map to 0 (Monday) - 6 (Sunday).
    _selectedDayOfWeek = DateTime.now().weekday - 1;
  }

  void _showLogSetDialog(BuildContext context, String exerciseName, String targetReps, int targetSets) {
    final weightController = TextEditingController();
    // Pre-fill target reps by parsing the ending number of ranges like "8-12"
    final parsedReps = targetReps.split('-').last.replaceAll(RegExp(r'[^0-9]'), '');
    final repsController = TextEditingController(text: parsedReps);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Log Set: $exerciseName', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: weightController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  hintText: '0.0 for bodyweight',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: repsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Reps Completed',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                final weight = double.tryParse(weightController.text) ?? 0.0;
                final reps = int.tryParse(repsController.text) ?? 0;
                
                if (reps > 0) {
                  ref.read(workoutNotifierProvider.notifier).logSetComplete(exerciseName, reps, weight, targetSets);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Set'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutState = ref.watch(workoutNotifierProvider);
    final dailyLogsAsync = ref.watch(dailyExerciseLogProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Plan', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: workoutState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (plan) {
          if (plan == null || plan.daysJson.isEmpty) {
            return const Center(child: Text('No workout plan found.'));
          }

          // Parse the days
          final List<Map<String, dynamic>> days = plan.daysJson
              .map((e) => jsonDecode(e) as Map<String, dynamic>)
              .toList();

          // Calculate which routine maps to the selected day of the week
          final routineIndex = _selectedDayOfWeek % days.length;
          final currentDay = days[routineIndex];
          final exercises = currentDay['exercises'] as List<dynamic>? ?? [];

          // Parse daily logs to map completed sets quickly for the UI reactivity
          final dailyLogs = dailyLogsAsync.valueOrNull ?? [];
          final logsMap = {for (var log in dailyLogs) log.exerciseName: log};

          final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Horizontal Day Selector (7 Days of the week)
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedDayOfWeek == index;
                    final mappedRoutine = days[index % days.length];
                    
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(
                          '${weekDays[index]} - ${mappedRoutine['day_name']}',
                          style: TextStyle(
                            color: isSelected ? Colors.white : null,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedDayOfWeek = index;
                            });
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              
              // Day Focus Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Focus: ${currentDay['focus'] ?? ''}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Exercises List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    final name = exercise['name'] as String;
                    final targetSets = exercise['sets'] as int;
                    final repsStr = exercise['reps'].toString();

                    final log = logsMap[name];
                    final completedSetsCount = log?.completedSetsJson.length ?? 0;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Target: $targetSets sets x $repsStr',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: List.generate(targetSets, (setIndex) {
                                final isCompleted = setIndex < completedSetsCount;
                                return GestureDetector(
                                  onTap: isCompleted ? null : () => _showLogSetDialog(context, name, repsStr, targetSets),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: isCompleted ? [
                                        BoxShadow(
                                          color: Colors.green.withValues(alpha: 0.3),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        )
                                      ] : null,
                                    ),
                                    child: Icon(
                                      isCompleted ? Icons.check_circle : Icons.circle_outlined,
                                      color: isCompleted ? Colors.green : Colors.grey.shade400,
                                      size: 38,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
