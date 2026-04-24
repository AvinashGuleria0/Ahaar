import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MacroRingCard extends StatelessWidget {
  final String title;
  final double consumed;
  final double target;
  final Color progressColor;

  const MacroRingCard({
    Key? key,
    required this.title,
    required this.consumed,
    required this.target,
    required this.progressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1. Math Calculation (Guard against dividing by zero if target is undefined/0)
    final double safeTarget = target > 0 ? target : 1.0;
    
    // 2. Logic checks
    final double diff = target - consumed;
    final bool isOver = diff < 0;
    final double absoluteDiff = diff.abs();

    // 3. Percent clamping to prevent CircularPercentIndicator crash 
    // (the widget natively throws an AssertionError if percent > 1.0)
    final double rawPercent = consumed / safeTarget;
    final double displayPercent = rawPercent.clamp(0.0, 1.0);

    return Card(
      // We rely on the global CardThemeData configured in AppTheme for 
      // dark/light surface colors, shadow strength, and corner radiuses.
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 8.0,
              animation: true,
              animationDuration: 1200,
              circularStrokeCap: CircularStrokeCap.round,
              percent: displayPercent,
              // If over target, we dynamically switch the color to red to alert the user
              progressColor: isOver ? Colors.redAccent : progressColor,
              backgroundColor: progressColor.withValues(alpha: 0.15),
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    absoluteDiff.toStringAsFixed(1),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: isOver ? Colors.redAccent : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  Text(
                    isOver ? 'g over' : 'g left',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11.0,
                      color: isOver ? Colors.redAccent : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
