import 'package:flutter/material.dart';

import 'MSRoundedSquare.dart';

class MSCard extends StatelessWidget {
  MSCard({
    @required this.text,
    this.color,
    this.width = 265,
    this.height = 350,
  });
  final double width;
  final double height;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MSRoundedSquare(
      width: width,
      height: height,
      color: color,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
