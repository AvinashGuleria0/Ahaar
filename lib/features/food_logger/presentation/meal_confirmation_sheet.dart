import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/local_schemas.dart';
import '../../../core/theme/app_theme.dart';
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
          Builder(builder: (context) {
            final macroColors = Theme.of(context).extension<MacroColors>();
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light 
                    ? Colors.orange.shade50 
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _MacroBadge(label: "Kcal", value: currentMacros.calories, color: macroColors?.calories),
                  _MacroBadge(label: "Pro", value: currentMacros.protein, color: macroColors?.protein),
                  _MacroBadge(label: "Carb", value: currentMacros.carbs, color: macroColors?.carbs),
                  _MacroBadge(label: "Fat", value: currentMacros.fats, color: macroColors?.fats),
                ],
              ),
            );
          }),
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
                            return _IngredientRow(
                              ingredient: ing,
                              dishIndex: dishIndex,
                              ingredientIndex: ingIndex,
                              draftNotifier: draftNotifier,
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
  final Color? color;

  const _MacroBadge({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value.toStringAsFixed(0), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color ?? Colors.deepOrange)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

class _IngredientRow extends StatefulWidget {
  final DraftIngredient ingredient;
  final int dishIndex;
  final int ingredientIndex;
  final MealDraftNotifier draftNotifier;

  const _IngredientRow({
    required this.ingredient,
    required this.dishIndex,
    required this.ingredientIndex,
    required this.draftNotifier,
  });

  @override
  State<_IngredientRow> createState() => _IngredientRowState();
}

class _IngredientRowState extends State<_IngredientRow> {
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Default the field to the AI's predicted weight
    _controller = TextEditingController(text: widget.ingredient.weightG.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    // Debounce the recalculation by 400ms to prevent extreme stutter while typing
    _debounce = Timer(const Duration(milliseconds: 400), () {
      final double? parsed = double.tryParse(value);
      if (parsed != null) {
        widget.draftNotifier.updateIngredientWeight(
          widget.dishIndex,
          widget.ingredientIndex,
          parsed,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: !widget.ingredient.isExcluded,
      activeColor: Colors.deepOrange,
      title: Text(widget.ingredient.name),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 40,
              child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  suffixText: 'g',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                onChanged: _onChanged,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "·  ${widget.ingredient.calories.toStringAsFixed(0)} kcal",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ],
        ),
      ),
      onChanged: (bool? val) {
        widget.draftNotifier.toggleIngredient(widget.dishIndex, widget.ingredientIndex);
      },
    );
  }
}