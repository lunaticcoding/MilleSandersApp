import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final double x;
  final double y;
  final double width;
  final double height;
  final Color fillColor;

  TrianglePainter({
    @required this.x,
    @required this.y,
    this.width = 10,
    this.height = 10,
    this.fillColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = fillColor;

    Path path = Path()
      ..moveTo(x, y)
      ..quadraticBezierTo(x + width/3, y, x + width / 2, y + height)
      ..quadraticBezierTo(x + width*2/3, y, x + width, y)
      ..lineTo(x, y);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.fillColor != fillColor;
  }
}
