import 'package:flutter/material.dart';

class BoundingBoxPainter extends CustomPainter {
  final List<dynamic> dishes;
  final int? imageWidth;
  final int? imageHeight;

  BoundingBoxPainter(this.dishes, {this.imageWidth, this.imageHeight});

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
      List<dynamic> box = dish['bounding_box'];
      
      // FIX: Gemma outputs on a 0-1000 scale. We convert it to 0.0 - 1.0.
      double scale = box[0] > 1.0 ? 1000.0 : 1.0;

      double yMin = (box[0] / scale) * size.height;
      double xMin = (box[1] / scale) * size.width;
      double yMax = (box[2] / scale) * size.height;
      double xMax = (box[3] / scale) * size.width;

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