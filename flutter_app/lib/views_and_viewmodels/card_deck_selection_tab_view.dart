import 'package:flutter/material.dart';
import 'package:flutter_app/models/Cards.dart';
import 'package:flutter_app/custom_widgets/card.dart';
import 'package:provider/provider.dart';

import 'card_deck_selection_tab_viewmodel.dart';

class CardDeckSelectionTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cards = Provider.of<Cards>(context);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              "Heute möchte ich...",
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
                decorationColor: Colors.black,
                decorationStyle: TextDecorationStyle.solid,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Flexible(
              child: ListView.builder(
                itemCount: cards.cardCategories.length,
                itemBuilder: (BuildContext ctxt, int index) => Column(
                  children: <Widget>[
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) =>
                              Container(
                        width: constraints.maxWidth,
                        child: Text(
                          cards.cardCategories[index].first.section,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    LayoutBuilder(
                      builder: (context, constraints) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          DisplayCard(
                            elevation: 0,
                            width: constraints.maxWidth / 2 - 15,
                            color: cards.cardCategories[index].first.color,
                            onTap: () =>
                                CardDeckSelectionTabViewModel.displayCardsFor(
                              context: context,
                              category: cards.cardCategories[index].first.category,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  cards.cardCategories[index].first.category,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Icon(
                                  cards.cardCategories[index].first.icon,
                                  size: 80,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          DisplayCard(
                            elevation: 0,
                            width: constraints.maxWidth / 2 - 15,
                            color: cards.cardCategories[index].last.color,
                            onTap: () =>
                                CardDeckSelectionTabViewModel.displayCardsFor(
                              context: context,
                              category: cards.cardCategories[index].last.category,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  cards.cardCategories[index].last.category,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Icon(
                                  cards.cardCategories[index].last.icon,
                                  size: 80,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
