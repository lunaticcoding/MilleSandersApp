import 'package:flutter/cupertino.dart';
import 'package:growthdeck/models/Decks.dart';

class CardDisplayViewModel extends ChangeNotifier {
  String deckName;
  Map<String, bool> filters;
  bool isReady = false;

  CardDeck _unfilteredCards;
  List<Card> _cards;
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

    _unfilteredCards = cardDeck;
    deckName = cardDeck.name;

    filters = Map.fromIterable(_unfilteredCards.filters,
        key: (v) => v.toString(), value: (v) => false);
    _cards = _unfilteredCards.cards.map((elem) => elem).toList();
    isReady = true;
    notifyListeners();
  }

  int getNrValidCards() => _cards.length - _index;
  bool isDeckEmpty() => _index >= _cards.length;
  bool isDeckFull() => _index == 0;

  Future animateToNextCard() async {
    if (!isDeckEmpty()) {
      await animationController.forward();
      animationController.reset();
      removeCard();
    }
  }

  void removeCard() {
    if (_index < _cards.length) {
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
    _cards.shuffle();
    _index = 0;
    notifyListeners();
  }

  List forEachCard<T>(Function function) {
    List<T> list = List<T>();
    for (int i = _index; i < _cards.length; i++) {
      list.insert(0, function(i - _index, _cards[i]));
    }
    return list;
  }

  void updateFilter() {
    _index = 0;
    _cards = _unfilteredCards.cards;

    bool applyFilters = filters.values.reduce((val, elem) => val || elem);
    if (applyFilters) {
      _cards = _cards.where(
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
