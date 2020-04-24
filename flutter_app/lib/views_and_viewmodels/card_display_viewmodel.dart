import 'package:flutter/cupertino.dart';

class CardDisplayViewmodel extends ChangeNotifier {
  dynamic _unfilteredCards;
  List<dynamic> _cards;

  bool isReady = false;
  Map<String, bool> filters;

  String deckName;
  int _index = 0;

  CardDisplayViewmodel(cardDeck) {
    _unfilteredCards = cardDeck;
    deckName = _unfilteredCards["deckName"];

    filters = Map.fromIterable(cardDeck["filterIcons"],
        key: (v) => v.toString(), value: (v) => false);
    _cards = cardDeck["cards"].map((elem) => elem).toList();
    isReady = true;
    notifyListeners();
  }

  int getNrValidCards() => _cards.length - _index;

  bool addCard() {
    if (_index > 0) {
      _index--;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool removeCard() {
    if (_index < _cards.length) {
      _index++;
      notifyListeners();
      return true;
    }
    return false;
  }

  List<Widget> forEachCard(Function function) {
    List<dynamic> list = List<Widget>();
    for (int i = _index; i < _cards.length; i++) {
      list.insert(0, function(i == _index, _cards[i]));
    }
    return list;
  }

  void updateFilter() {
    _index = 0;
    _cards = _unfilteredCards["cards"];

    bool applyFilters = filters.values.reduce((val, elem) => val || elem);
    if (applyFilters) {
      _cards = _cards.where(
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
    notifyListeners();
  }
}
