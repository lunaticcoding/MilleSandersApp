import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constants/k_colors.dart';
import 'package:flutter_app/models/Cards.dart';
import 'package:flutter_app/views_and_viewmodels/card_display_view.dart';

class CardDisplayViewmodel extends ChangeNotifier {
  final AnimationController _animationController;
  final Animation _animationTranslation;
  final Animation _animationRotation;

  Map<String, bool> filters;
  dynamic _cardDeck;
  List<dynamic> cards;
  String deckName;
  int index = 0;

  CardDisplayViewmodel(this._animationController, this._animationTranslation,
      this._animationRotation, cardDeck) {
    _cardDeck = cardDeck;
    deckName = _cardDeck["deckName"];

    filters = Map.fromIterable(cardDeck["filterIcons"],
        key: (v) => v.toString(), value: (v) => false);
    cards = cardDeck["cards"].map((elem) => elem).toList();
  }

  // TODO split this method up!!!
  List<Widget> getCardDeck() {
    List<Widget> list = List<Widget>();

    for (int i = index; i < cards.length; i++) {
      dynamic card = cards[i];
      // TODO apply filters ;D
      if (i == index) {
        list.insert(
            0,
            FirstCard(
              text: card["text"],
              color: Cards.colorFromHex(card["color"]),
              onDragEnd: (_) => _removeCard(),
              animationRotation: _animationRotation,
              animationTranslation: _animationTranslation,
            ));
      } else {
        list.insert(
          0,
          SecondCard(
            text: card["text"],
            color: Cards.colorFromHex(card["color"]),
            elevation: i == cards.length - 1 ? 6 : 0,
          ),
        );
      }
    }
    if (list.length < 2) {
      list.insert(
        0,
        LastCard(
          onTap: () {
            index = 0;
            notifyListeners();
          },
        ),
      );
    }
    return list;
  }

  void prevCard() async {
    if (index == 0) {
      return;
    }
    _addCard();
    await _animationController.reverse(from: 1.0);
  }

  void _addCard() {
    index--;
    notifyListeners();
  }

  void nextCard() async {
    if (index < cards.length) {
      await _animationController.forward();
      _removeCard();
      _animationController.reset();
    }
  }

  void _removeCard() {
    index++;
    notifyListeners();
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
  notifyListeners();
}
