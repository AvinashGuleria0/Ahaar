import 'package:flutter_riverpod/flutter_riverpod.dart';

class DraftIngredient {
  const DraftIngredient({
    required this.name,
    this.weightG = 0.0,
    this.calories = 0.0,
    this.protein = 0.0,
    this.carbs = 0.0,
    this.fats = 0.0,
    this.isExcluded = false,
  });

  final String name;
  final double weightG;
  final double calories;
  final double protein;
  final double carbs;
  final double fats;
  final bool isExcluded;

  DraftIngredient copyWith({
    String? name,
    double? weightG,
    double? calories,
    double? protein,
    double? carbs,
    double? fats,
    bool? isExcluded,
  }) {
    return DraftIngredient(
      name: name ?? this.name,
      weightG: weightG ?? this.weightG,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      isExcluded: isExcluded ?? this.isExcluded,
    );
  }

  factory DraftIngredient.fromJson(Map<String, dynamic> json) {
    return DraftIngredient(
      name: (json['name'] ?? '').toString(),
      weightG: (json['weightG'] ?? 0.0).toDouble(),
      calories: (json['calories'] ?? 0.0).toDouble(),
      protein: (json['protein'] ?? 0.0).toDouble(),
      carbs: (json['carbs'] ?? 0.0).toDouble(),
      fats: (json['fats'] ?? 0.0).toDouble(),
      isExcluded: json['isExcluded'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weightG': weightG,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'isExcluded': isExcluded,
    };
  }
}

class DraftDish {
  const DraftDish({
    required this.dishName,
    this.gravyStatus = '',
    this.portionMultiplier = 1.0,
    this.ingredients = const [],
  });

  final String dishName;
  final String gravyStatus;
  final double portionMultiplier;
  final List<DraftIngredient> ingredients;

  DraftDish copyWith({
    String? dishName,
    String? gravyStatus,
    double? portionMultiplier,
    List<DraftIngredient>? ingredients,
  }) {
    return DraftDish(
      dishName: dishName ?? this.dishName,
      gravyStatus: gravyStatus ?? this.gravyStatus,
      portionMultiplier: portionMultiplier ?? this.portionMultiplier,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  factory DraftDish.fromJson(Map<String, dynamic> json) {
    final ing = (json['ingredients'] as List? ?? const [])
        .whereType<Map>()
        .map((e) => DraftIngredient.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return DraftDish(
      dishName: (json['dishName'] ?? '').toString(),
      gravyStatus: (json['gravyStatus'] ?? '').toString(),
      portionMultiplier: (json['portionMultiplier'] ?? 1.0).toDouble(),
      ingredients: ing,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dishName': dishName,
      'gravyStatus': gravyStatus,
      'portionMultiplier': portionMultiplier,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
    };
  }
}

class MealDraftNotifier extends Notifier<List<DraftDish>> {
  @override
  List<DraftDish> build() {
    return []; // Empty until the user scans a meal
  }

  /// Parses the FastAPI JSON response dynamically and populates the state.
  /// Uses a robust manual mapping to avoid nested macro crashing.
  void initializeFromAI(Map<String, dynamic> aiJson) {
    try {
      if (aiJson['dishes'] != null && aiJson['dishes'] is List) {
        final dishesList = aiJson['dishes'] as List;
        
        final parsedDishes = dishesList.map((dishData) {
          final ingredientsList = dishData['ingredients'] as List? ?? [];
          
          final parsedIngredients = ingredientsList.map((ingData) {
            // Check if macros are nested or flat depending on backend format
            final macros = ingData['macros'] is Map ? ingData['macros'] : ingData;
            
            return DraftIngredient(
              name: ingData['ai_name'] ?? ingData['db_matched_name'] ?? ingData['name'] ?? 'Unknown Ingredient',
              weightG: (ingData['weight_g'] ?? 0.0).toDouble(),
              calories: (macros['calories'] ?? 0.0).toDouble(),
              protein: (macros['protein_g'] ?? macros['protein'] ?? 0.0).toDouble(),
              carbs: (macros['carbs_g'] ?? macros['carbs'] ?? 0.0).toDouble(),
              fats: (macros['fats_g'] ?? macros['fats'] ?? 0.0).toDouble(),
              isExcluded: false,
            );
          }).toList();

          return DraftDish(
            dishName: dishData['dish_name'] ?? 'Unknown Dish',
            // Accommodate boolean 'gravy_detected' or string 'gravy_status'
            gravyStatus: dishData['gravy_status']?.toString() ?? dishData['gravy_detected']?.toString() ?? '',
            portionMultiplier: 1.0,
            ingredients: parsedIngredients,
          );
        }).toList();

        state = parsedDishes;
      }
    } catch (e) {
      print('CRITICAL: Error parsing AI response in MealDraftNotifier: $e');
      state = [];
    }
  }

  /// Flips the isExcluded boolean for an ingredient safely utilizing Freezed's copyWith 
  /// to trigger an implicit reactive UI rebuild.
  void toggleIngredient(int dishIndex, int ingredientIndex) {
    final dish = state[dishIndex];
    final ingredient = dish.ingredients[ingredientIndex];

    // Immutable clone of the ingredient toggling the state
    final updatedIngredient = ingredient.copyWith(isExcluded: !ingredient.isExcluded);

    // Swap it into a new list
    final updatedIngredients = List<DraftIngredient>.from(dish.ingredients);
    updatedIngredients[ingredientIndex] = updatedIngredient;

    // Swap the list into a new dish
    final updatedDish = dish.copyWith(ingredients: updatedIngredients);

    // Swap the dish into the new state
    final updatedState = List<DraftDish>.from(state);
    updatedState[dishIndex] = updatedDish;

    // Assigning new state triggers the Riverpod rebuild
    state = updatedState;
  }

  /// Feature Addition: Adjust portions via UI (+/- buttons)
  void updatePortionMultiplier(int dishIndex, double newMultiplier) {
    final dish = state[dishIndex];
    final updatedState = List<DraftDish>.from(state);
    updatedState[dishIndex] = dish.copyWith(portionMultiplier: newMultiplier);
    state = updatedState;
  }

  /// Returns a strictly typed Dart 3 Record computing totals of non-excluded items
  ({double calories, double protein, double carbs, double fats}) calculateTotalMacros() {
    double totalCals = 0.0;
    double totalPro = 0.0;
    double totalCarbs = 0.0;
    double totalFats = 0.0;

    for (final dish in state) {
      for (final ing in dish.ingredients) {
        if (!ing.isExcluded) {
          totalCals += ing.calories * dish.portionMultiplier;
          totalPro += ing.protein * dish.portionMultiplier;
          totalCarbs += ing.carbs * dish.portionMultiplier;
          totalFats += ing.fats * dish.portionMultiplier;
        }
      }
    }

    return (
      calories: totalCals,
      protein: totalPro,
      carbs: totalCarbs,
      fats: totalFats,
    );
  }
}

/// The global provider our UI will watch for drawing the confirmation screen.
final mealDraftProvider = NotifierProvider<MealDraftNotifier, List<DraftDish>>(() {
  return MealDraftNotifier();
});