import 'package:flutter/material.dart';
import 'package:growthdeck/constants/k_colors.dart';

class MSProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kColors.gold),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
