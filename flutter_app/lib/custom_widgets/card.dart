import 'package:flutter/material.dart';

class DisplayCard extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final IconData icon;
  final Color color;
  final onTap;
  final double elevation;
  final double iconSize;

  DisplayCard(
      {@required this.width,
      this.height,
      this.text,
      this.icon,
      this.color,
      this.onTap,
      this.elevation = 5,
      this.iconSize = 80});

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
              offset: Offset(elevation, elevation), //(x,y)
              blurRadius: elevation == 0 ? 0 : 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            text != null
                ? Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      fontSize: 15,
                    ),
                  )
                : null,
            text != null && icon != null ? SizedBox(height: 10) : null,
            icon != null
                ? Icon(
                    icon,
                    size: iconSize,
                    color: Colors.white,
                  )
                : null,
          ].where((value) => value != null).toList(),
        ),
      ),
    );
  }
}
