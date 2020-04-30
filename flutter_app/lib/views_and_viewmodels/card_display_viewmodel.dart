import 'package:flutter/cupertino.dart';
import 'package:growthdeck/models/Cards.dart';

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

  CardDisplayViewModel(TickerProvider tickerProvider) {
    animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: tickerProvider,
    );

    animationTranslation = new Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(200, 50),
    ).animate(animationController)
      ..addListener(notifyListeners);

    animationRotation = new Tween<double>(
      begin: 0,
      end: 0.2,
    ).animate(animationController)
      ..addListener(notifyListeners);
  }

  void initWithSelectedDeck(CardDeck cardDeck) {
    if (cardDeck == null) {
      return;
    }
    _unfilteredCards = cardDeck;
    deckName = cardDeck.name;

    filters = Map.fromIterable(_unfilteredCards.filters,
        key: (v) => v.toString(), value: (v) => false);
    _cards = _unfilteredCards.cards.map((elem) => elem).toList();
    isReady = true;
    notifyListeners();
  }

  int getNrValidCards() => _cards.length - _index;
  bool isDeckEmpty() => _index >= _cards.length ;
  bool isDeckFull() => _index == 0;

  void animateToNextCard() async {
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

  void animateToPrevCard() async {
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

  List<Widget> forEachCard(Function function) {
    List<dynamic> list = List<Widget>();
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
