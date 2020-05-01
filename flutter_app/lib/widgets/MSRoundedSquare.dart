import 'package:flutter/material.dart';

class MSRoundedSquare extends StatelessWidget {
  MSRoundedSquare(
      {@required this.width,
      this.height,
      this.color,
      this.onTap,
      this.elevation = 6,
      this.iconSize = 80,
      this.child});

  final double width;
  final double height;
  final Color color;
  final onTap;
  final double elevation;
  final double iconSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.6),
              offset: Offset(elevation, elevation),
              blurRadius: elevation,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
