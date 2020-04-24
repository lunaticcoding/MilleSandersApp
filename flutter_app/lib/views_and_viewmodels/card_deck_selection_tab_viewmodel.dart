import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/locator.dart';
import 'package:growthdeck/models/Cards.dart';

import 'card_deck_selection_tab_view.dart';

class CardDeckSelectionTabViewModel extends ChangeNotifier {
  List<dynamic> cards;
  List<int> indices;
  List<ScrollController> scrollControllerList;
  String error;

  CardDeckSelectionTabViewModel() {
    locator.allReady().then((_) {
      cards = locator<Cards>().data;
      error = locator<Cards>().error;

      indices = List<int>();
      scrollControllerList = List<ScrollController>();

      for (var _ in locator<Cards>().data) {
        scrollControllerList.add(ScrollController());
        indices.add(0);
      }
      notifyListeners();
    });
  }

  void refreshDeck() {
    locator<Cards>().reloadData();
    cards = locator<Cards>().data;
    error = locator<Cards>().error;
    notifyListeners();
  }

  // TODO move into view (is ui code)
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
