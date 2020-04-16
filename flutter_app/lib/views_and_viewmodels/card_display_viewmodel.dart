import 'package:flutter/cupertino.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/models/CardDetails.dart';
import 'package:flutter_app/models/Cards.dart';
import 'package:flutter_app/views_and_viewmodels/card_display_view.dart';

class CardDisplayViewmodel extends ChangeNotifier {
  Cards cards = locator<Cards>();
  AnimationController _animationController;
  int index = 0;

  CardDisplayViewmodel(this._animationController);

  List<Widget> getCardDeck() {
    List<Widget> list = List<Widget>();

    for (int i = index; i < cards.cardDeck.length; i++) {
      CardDetail card = cards.cardDeck[i];
      if (i == index) {
        list.insert(
            0,
            FirstCard(
              text: card.text,
              author: card.author,
              color: card.color,
              onDragEnd: (_) => _removeCard(),
              animationController: _animationController,
            ));
      } else {
        list.insert(
            0,
            SecondCard(
              text: card.text,
              author: card.author,
              color: card.color,
              elevation: i == cards.cardDeck.length - 1 ? 6 : 0,
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
    if(index == 0 ) { return; }
    _addCard();
    await _animationController.reverse(from: 1.0);
  }

  void _addCard() {
    index--;
    notifyListeners();
  }

  void nextCard() async {
      await _animationController.forward();
      _removeCard();
      _animationController.reset();
  }

  void _removeCard() {
    index++;
    notifyListeners();
  }
}
