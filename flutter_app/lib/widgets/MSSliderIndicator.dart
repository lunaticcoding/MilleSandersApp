import 'package:flutter/material.dart';

class MSSliderIndicator extends StatelessWidget {
  MSSliderIndicator({@required this.cardDecks, @required this.selectedIndex});

  final List<dynamic> cardDecks;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return cardDecks.length > 2
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: cardDecks
                .take(cardDecks.length - 1)
                .toList()
                .map<Widget>((card) {
              int i = cardDecks.indexOf(card);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 0.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == selectedIndex
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          )
        : SizedBox(height: 18);
  }
}
