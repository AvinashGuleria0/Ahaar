import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/local_schemas.dart';
import '../../dashboard/domain/daily_log_notifier.dart';
import '../domain/meal_draft_notifier.dart';

class MealConfirmationSheet extends ConsumerStatefulWidget {
  const MealConfirmationSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<MealConfirmationSheet> createState() => _MealConfirmationSheetState();
}

class _MealConfirmationSheetState extends ConsumerState<MealConfirmationSheet> {
  // Default to lunch, but user can change it
  String _selectedMealType = 'lunch';
  
  final List<String> _mealTypes = [
    'breakfast',
    'lunch',
    'snack',
    'dinner',
    'dessert',
    'late_night'
  ];

  void _saveToDiary() async {
    final draftNotifier = ref.read(mealDraftProvider.notifier);
    final macros = draftNotifier.calculateTotalMacros();

    final newMeal = LocalMeal()
      ..mealType = _selectedMealType
      ..loggedAt = DateTime.now()
      ..calories = macros.calories
      ..protein = macros.protein
      ..carbs = macros.carbs
      ..fats = macros.fats;

    try {
      await ref.read(dailyLogProvider.notifier).addMeal(newMeal);
      
      if (mounted) {
        Navigator.pop(context); // Close the bottom sheet
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("✅ Meal saved to diary successfully!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error saving meal: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final draftedDishes = ref.watch(mealDraftProvider);
    final draftNotifier = ref.read(mealDraftProvider.notifier);
    final currentMacros = draftNotifier.calculateTotalMacros();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER & MEAL TYPE PICKER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Confirm Meal",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _selectedMealType,
                items: _mealTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.toUpperCase(), style: const TextStyle(fontSize: 14)),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedMealType = val);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          
          // LIVE MACRO SUM SUMMARY
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MacroBadge(label: "Kcal", value: currentMacros.calories),
                _MacroBadge(label: "Pro", value: currentMacros.protein),
                _MacroBadge(label: "Carb", value: currentMacros.carbs),
                _MacroBadge(label: "Fat", value: currentMacros.fats),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),

          // DISHES LIST
          Expanded(
            child: draftedDishes.isEmpty
                ? const Center(child: Text("No dishes found or parsed."))
                : ListView.builder(
                    itemCount: draftedDishes.length,
                    itemBuilder: (context, dishIndex) {
                      final dish = draftedDishes[dishIndex];
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 0,
                        color: Colors.grey.shade100,
                        child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  dish.dishName,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Portion multiplier UI
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline, color: Colors.orange),
                                    onPressed: dish.portionMultiplier > 0.25 
                                      ? () => draftNotifier.updatePortionMultiplier(dishIndex, dish.portionMultiplier - 0.25)
                                      : null,
                                  ),
                                  Text("${dish.portionMultiplier}x"),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline, color: Colors.orange),
                                    onPressed: () => draftNotifier.updatePortionMultiplier(dishIndex, dish.portionMultiplier + 0.25),
                                  ),
                                ],
                              )
                            ],
                          ),
                          children: dish.ingredients.asMap().entries.map((entry) {
                            final ingIndex = entry.key;
                            final ing = entry.value;
                            return CheckboxListTile(
                              value: !ing.isExcluded, // If true, it's included
                              activeColor: Colors.deepOrange,
                              title: Text(ing.name),
                              subtitle: Text(
                                "${ing.weightG.toStringAsFixed(1)}g · ${ing.calories.toStringAsFixed(0)} kcal",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              onChanged: (bool? val) {
                                draftNotifier.toggleIngredient(dishIndex, ingIndex);
                              },
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
          ),
          
          // SAVE BUTTON
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: draftedDishes.isEmpty ? null : _saveToDiary,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Save to Daily Log", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}

class _MacroBadge extends StatelessWidget {
  final String label;
  final double value;

  const _MacroBadge({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value.toStringAsFixed(0), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepOrange)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}