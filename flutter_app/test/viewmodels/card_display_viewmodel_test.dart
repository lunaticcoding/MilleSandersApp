import 'package:flutter_test/flutter_test.dart';
import 'package:growthdeck/viewmodels/card_display_viewmodel.dart';
import 'package:growthdeck/models/Decks.dart';

import '../mockData.dart';
import '../mocks.dart';

void main() {
  AnimationControllerMock animationControllerMock;
  AnimationMock translationMock;
  AnimationMock rotationMock;
  CardDisplayViewModel model;

  setUp(() {
    animationControllerMock = AnimationControllerMock();
    translationMock = AnimationMock();
    rotationMock = AnimationMock();

    model = CardDisplayViewModel(
        animationController: animationControllerMock,
        animationTranslation: translationMock,
        animationRotation: rotationMock,
        cardDeck: filledCardDeckMock);
  });

  group('test card deck', () {
    test('has deckName', () {
      expect(model.deckName, isNotNull);
    });

    test('has remove card on non empty deck', () async {
      int nCards = model.getNrValidCards();
      model.removeCard();
      await model.animateToNextCard();
      expect(model.getNrValidCards(), nCards - 2);
    });

    test('has add card on non full deck', () async {
      await model.animateToNextCard();
      int nCards = model.getNrValidCards();
      await model.animateToPrevCard();
      expect(model.getNrValidCards(), nCards + 1);
    });

    test('shuffles deck - might fail because test is probabilistic', () async {
      List<Card> cardDeck = model.forEachCard<Card>((_, card) => card);
      model.shuffleDeck();
      bool isShuffled = false;
      model.forEachCard((i, Card cardAfterShuffle) {
        isShuffled = isShuffled || (cardAfterShuffle != cardDeck[i]);
      });
      expect(isShuffled, true);
    });
  });

  group('test filter', () {
    test('no filters returns all cards', () {
      int allCards = filledCardDeckMock.cards.length;
      model.filters.forEach((key, _) => model.filters[key] = false);
      model.updateFilter();
      expect(model.getNrValidCards(), allCards);
    });

    test('applying one filter filters out 2 cards', () {
      int magicNumberCards = 2;
      model.filters[model.filters.keys.first] = true;
      model.updateFilter();
      expect(model.getNrValidCards(), magicNumberCards);
    });

    test('applying all filter filters only card with no filter', () {
      int magicNumberCards = 3;
      model.filters.forEach((key, _) => model.filters[key] = true);
      model.updateFilter();
      expect(model.getNrValidCards(), magicNumberCards);
    });
  });
}
