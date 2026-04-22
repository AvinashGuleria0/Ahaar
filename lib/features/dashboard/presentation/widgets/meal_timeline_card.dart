import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/local_schemas.dart';

class MealTimelineCard extends StatelessWidget {
  final LocalMeal meal;

  const MealTimelineCard({Key? key, required this.meal}) : super(key: key);

  /// Dynamically maps the backend 'MealType' enum strings to appropriate generic Material icons.
  IconData _getMealIcon(String type) {
    switch (type.toLowerCase()) {
      case 'breakfast':
        return Icons.wb_sunny_outlined;
      case 'lunch':
        return Icons.wb_twilight_outlined;
      case 'snack':
        return Icons.local_pizza_outlined;
      case 'dinner':
        return Icons.nightlight_round;
      case 'dessert':
        return Icons.icecream_outlined;
      case 'late_night':
        return Icons.bedtime_outlined;
      default:
        return Icons.restaurant_menu;
    }
  }

  /// Capitalizes strings like 'late_night' into 'Late Night'
  String _formatMealType(String type) {
    if (type.isEmpty) return type;
    final parts = type.split('_');
    return parts.map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final iconData = _getMealIcon(meal.mealType);
    final titleText = _formatMealType(meal.mealType);
    final timeText = DateFormat.jm().format(meal.loggedAt);

    // Enforcing whole integers for clean line-wrapping (.toStringAsFixed(0))
    final String cals = meal.calories.toStringAsFixed(0);
    final String p = meal.protein.toStringAsFixed(0);
    final String c = meal.carbs.toStringAsFixed(0);
    final String f = meal.fats.toStringAsFixed(0);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        // Dynamically respect the dark/light mode surface contrast
        side: BorderSide(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
          width: 1.0,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.05),
            shape: BoxShape.circle,
          ),
          // Generic icon tint inherently matching standard theme constraints
          child: Icon(iconData, size: 24),
        ),
        title: Text(
          titleText,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            '🔥 $cals kcal | 🥩 ${p}g P | 🍚 ${c}g C | 🧈 ${f}g F',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            maxLines: 1, // Guarantees the row stays precisely on one line
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Text(
          timeText,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
          ),
        ),
      ),
    );
  }
}
