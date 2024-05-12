import 'package:flutter/material.dart';

class AxesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromARGB(255, 126, 10, 10)
      ..strokeWidth = 4;

    // Draw X axis
    canvas.drawLine(Offset(size.width * 0.1, size.height / 2),
        Offset(size.width * 0.9, size.height / 2), paint);

    // Draw Y axis
    canvas.drawLine(Offset(size.width / 2, size.height * 0.12),
        Offset(size.width / 2, size.height * 0.9), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
