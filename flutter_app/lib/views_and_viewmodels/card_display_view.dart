import 'package:flutter/material.dart';
import 'package:flutter_app/constants/k_colors.dart';
import 'package:flutter_app/constants/the_noun_project_icons_icons.dart';
import 'package:flutter_app/custom_widgets/card.dart';

class CardDisplayView extends StatefulWidget {
  final String category;

  CardDisplayView({Key key, this.category}) : super(key: key);

  @override
  _CardDisplayViewState createState() => _CardDisplayViewState();
}

class _CardDisplayViewState extends State<CardDisplayView> {
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                  child: DisplayCard(
                    width: 300,
                    height: 370,
                    text: widget.category,
                    color: kColors.beige,
                  ),
                ),
                DisplayCard(
                  width: 300,
                  height: 400,
                  text: widget.category,
                  color: kColors.gold,
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DisplayCard(
                    iconSize: 40,
                    icon: TheNounProjectIcons.noun_arrows_left,
                    width: 60,
                    elevation: 0,
                    color: kColors.brown,
                  ),
                  DisplayCard(
                    iconSize: 40,
                    icon: TheNounProjectIcons.noun_arrows_left,
                    width: 60,
                    elevation: 0,
                    color: kColors.grey,
                  ),
                  DisplayCard(
                    iconSize: 40,
                    icon: TheNounProjectIcons.noun_bookmark,
                    width: 60,
                    elevation: 0,
                    color: kColors.beige,
                  ),
                  DisplayCard(
                    iconSize: 40,
                    icon: TheNounProjectIcons.noun_arrows_right,
                    width: 60,
                    elevation: 0,
                    color: kColors.gold,
                  ),
                ],
              ),
            )
          ],
        ),
    );
}
