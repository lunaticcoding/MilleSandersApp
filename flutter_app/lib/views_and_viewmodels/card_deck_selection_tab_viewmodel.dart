import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/models/Cards.dart';

import 'card_deck_selection_tab_view.dart';

class CardDeckSelectionTabViewModel extends ChangeNotifier {
  List<dynamic> cards;
  String error;

  CardDeckSelectionTabViewModel() {
    locator.allReady().then((_) {
      cards = locator<Cards>().data;
      error = locator<Cards>().error;
      notifyListeners();
    });
  }

  void reloadDeck() {
    locator<Cards>().reloadData();
    cards = locator<Cards>().data;
    error = locator<Cards>().error;
    notifyListeners();
  }

  List<Widget> getRowCards(dynamic cards, BoxConstraints constraints) {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < cards.length; i++) {
      var card = cards[i];
      if (list.isNotEmpty) {
        list.add(SizedBox(width: 20));
      }
      list.add(
        DeckCard(
          constraints: constraints,
          color: Cards.colorFromHex(card["color"]),
          text: card["deckName"],
          iconData: Cards.getIcon(card["icon"]),
          deck: card,
        ),
      );
    }
    return list;
  }
}
