import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constants/k_colors.dart';
import 'package:flutter_app/models/Cards.dart';
import 'package:flutter_app/views_and_viewmodels/card_display_view.dart';

class CardDisplayViewmodel extends ChangeNotifier {
  final AnimationController _animationController;
  final Animation _animationTranslation;
  final Animation _animationRotation;

  dynamic cardDeck;
  int index = 0;

  CardDisplayViewmodel(this._animationController, this._animationTranslation,
      this._animationRotation, this.cardDeck);

  // TODO split this method up!!!
  List<Widget> getCardDeck() {
    List<Widget> list = List<Widget>();

    for (int i = index; i < cardDeck["cards"].length; i++) {
      dynamic card = cardDeck["cards"][i];
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
            elevation: i == cardDeck["cards"].length - 1 ? 6 : 0,
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
    if (index < cardDeck["cards"].length) {
      await _animationController.forward();
      _removeCard();
      _animationController.reset();
    }
  }

  void _removeCard() {
    index++;
    notifyListeners();
  }
}
