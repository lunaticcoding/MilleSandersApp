import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constants/k_colors.dart';
import 'package:flutter_app/views_and_viewmodels/card_display_view.dart';

class CardDisplayViewmodel extends ChangeNotifier {
  final AnimationController _animationController;
  final Animation _animationTranslation;
  final Animation _animationRotation;

  dynamic cardDeck;
  int index = 0;
  List<Color> _colors = [
    kColors.brown,
    kColors.grey,
    kColors.beige,
    kColors.gold
  ];

  CardDisplayViewmodel(this._animationController, this._animationTranslation,
      this._animationRotation, this.cardDeck);

  List<Widget> getCardDeck() {
    List<Widget> list = List<Widget>();

    for (int i = index; i < cardDeck["cards"].length; i++) {
      dynamic card = cardDeck["cards"][i];
      if (i == index) {
        list.insert(
            0,
            FirstCard(
              text: card["html"],
              color: _colors[i % _colors.length],
              onDragEnd: (_) => _removeCard(),
              animationRotation: _animationRotation,
              animationTranslation: _animationTranslation,
            ));
      } else {
        list.insert(
            0,
            SecondCard(
              text: card["html"],
              color: _colors[i % _colors.length],
              elevation: i == cardDeck["cards"].length - 1 ? 6 : 0,
            ));
      }
    }
    if (list.length < 2) {
      list.insert(
        0,
        LastCard(
          onTap: _resetIndex,
        ),
      );
    }
    return list;
  }

  void _resetIndex() {
    index = 0;
    notifyListeners();
  }

  void lastCard() async {
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
