import 'package:flutter/material.dart';

class BoundingBoxPainter extends CustomPainter {
  final List<dynamic> dishes;

  BoundingBoxPainter(this.dishes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (var dish in dishes) {
      // The API returns[y_min, x_min, y_max, x_max] as percentages (0.0 to 1.0)
      List<dynamic> box = dish['bounding_box'];
      
      // Convert percentages to actual screen pixels
      double yMin = box[0] * size.height;
      double xMin = box[1] * size.width;
      double yMax = box[2] * size.height;
      double xMax = box[3] * size.width;

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