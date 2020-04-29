import 'package:flutter/material.dart';
import 'MSRoundedSquare.dart';

class MSRoundedIconButton extends StatelessWidget {
  MSRoundedIconButton({
    @required this.icon,
    @required this.color,
    this.onTap,
  });

  final Function onTap;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MSRoundedSquare(
        width: 60,
        elevation: 0,
        color: color,
        child: Icon(
          icon,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
