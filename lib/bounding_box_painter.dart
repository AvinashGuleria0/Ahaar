import 'dart:math';
import 'package:flutter/material.dart';

class BoundingBoxPainter extends CustomPainter {
  final List<dynamic> dishes;
  final double imageOriginalWidth;
  final double imageOriginalHeight;

  BoundingBoxPainter(
    this.dishes, {
    required this.imageOriginalWidth,
    required this.imageOriginalHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Calculate scaling and padding (letterboxing equivalent for BoxFit.contain)
    // Avoid division by zero by setting a tiny default if 0
    final double safeImgW = imageOriginalWidth > 0 ? imageOriginalWidth : 1;
    final double safeImgH = imageOriginalHeight > 0 ? imageOriginalHeight : 1;

    final double scale = min(size.width / safeImgW, size.height / safeImgH);
    final double renderedWidth = safeImgW * scale;
    final double renderedHeight = safeImgH * scale;

    final double dx = (size.width - renderedWidth) / 2;
    final double dy = (size.height - renderedHeight) / 2;

    for (var dish in dishes) {
      List<dynamic> box = dish['bounding_box'];
      
      // FIX: Models typically output on a 0-1000 scale. We convert it to 0.0 - 1.0.
      double aiScale = box[0] > 1.0 || box[1] > 1.0 || box[2] > 1.0 || box[3] > 1.0 ? 1000.0 : 1.0;

      // The AI format is typically [y_min, x_min, y_max, x_max] based on 0-1000 bounds relative to the raw image constraint
      double yMin = (box[0] / aiScale) * renderedHeight + dy;
      double xMin = (box[1] / aiScale) * renderedWidth + dx;
      double yMax = (box[2] / aiScale) * renderedHeight + dy;
      double xMax = (box[3] / aiScale) * renderedWidth + dx;

      final rect = Rect.fromLTRB(xMin, yMin, xMax, yMax);
      canvas.drawRect(rect, paint);

      // Draw the Dish Name above the box
      textPainter.text = TextSpan(
        text: dish['dish_name'],
        style: const TextStyle(
          color: Colors.white,
          backgroundColor: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(xMin, yMin - 20));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}