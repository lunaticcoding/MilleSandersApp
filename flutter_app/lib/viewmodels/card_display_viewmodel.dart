import 'package:flutter/cupertino.dart';
import 'package:growthdeck/models/Decks.dart';

class CardDisplayViewModel extends ChangeNotifier {
  String deckName;
  Map<String, bool> filters;
  bool isReady = false;

  CardDeck _fullCardDeck;
  List<Card> _cardDeck;
  int _index = 0;

  AnimationController animationController;
  Animation animationTranslation;
  Animation animationRotation;

  CardDisplayViewModel(
      {this.animationController,
      this.animationTranslation,
      this.animationRotation,
      CardDeck cardDeck}) {
    animationTranslation.addListener(notifyListeners);
    animationRotation.addListener(notifyListeners);

    _fullCardDeck = cardDeck;
    deckName = cardDeck.name;

    filters = Map.fromIterable(_fullCardDeck.filters,
        key: (v) => v.toString(), value: (v) => false);
    _cardDeck = _fullCardDeck.cards.map((elem) => elem).toList();
    isReady = true;
    notifyListeners();
  }

  int getNrValidCards() => _cardDeck.length - _index;
  bool isDeckEmpty() => _index >= _cardDeck.length;
  bool isDeckFull() => _index == 0;

  Future animateToNextCard() async {
    if (!isDeckEmpty()) {
      await animationController.forward();
      animationController.reset();
      removeCard();
    }
  }

  void removeCard() {
    if (_index < _cardDeck.length) {
      _index++;
      notifyListeners();
    }
  }

  Future animateToPrevCard() async {
    if (!isDeckFull()) {
      await animationController.reverse(from: 1.0);
      _addCard();
    }
  }

  void _addCard() {
    if (_index > 0) {
      _index--;
      notifyListeners();
    }
  }

  void shuffleDeck() {
    _cardDeck.shuffle();
    _index = 0;
    notifyListeners();
  }

  List forEachCard<T>(Function function) {
    List<T> list = List<T>();
    for (int i = _index; i < _cardDeck.length; i++) {
      list.insert(0, function(i - _index, _cardDeck[i]));
    }
    return list;
  }

  void updateFilter() {
    _index = 0;
    _cardDeck = _fullCardDeck.cards;

    bool applyFilters = filters.values.reduce((val, elem) => val || elem);
    if (applyFilters) {
      _cardDeck = _cardDeck.where(
        (card) {
          for (var entry in filters.entries) {
            if (entry.value) {
              for (var filter in card.filters) {
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

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
