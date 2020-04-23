import 'package:flutter/cupertino.dart';

class CardDisplayViewmodel extends ChangeNotifier {
  dynamic _cardDeck;
  List<dynamic> cards;
  Map<String, bool> filters;

  String deckName;
  int index = 0;

  CardDisplayViewmodel(cardDeck) {
    _cardDeck = cardDeck;
    deckName = _cardDeck["deckName"];

    filters = Map.fromIterable(cardDeck["filterIcons"],
        key: (v) => v.toString(), value: (v) => false);
    cards = cardDeck["cards"].map((elem) => elem).toList();
  }

  void addCard() {
    if(index > 0) {
      index--;
    }
  }

  void removeCard() {
    if (index < cards.length) {
      index++;
    }
  }

  void updateFilter() {
    index = 0;
    cards = _cardDeck["cards"];

    bool applyFilters = filters.values.reduce((val, elem) => val || elem);
    if (applyFilters) {
      cards = cards.where(
        (card) {
          for (var entry in filters.entries) {
            if (entry.value) {
              for (var filter in card["filter"]) {
                if (filter == entry.key) {
                  return true;
                }
              }
            }
          }
          return false;
        },
      ).toList();
    }
  }
}
