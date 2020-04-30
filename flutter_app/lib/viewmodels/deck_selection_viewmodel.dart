import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:growthdeck/models/Decks.dart';

class DeckSelectionViewModel extends ChangeNotifier {
  bool isLoading = true;
  List<CardSection> cardSections;
  List<int> indices;
  List<ScrollController> scrollControllers;

  DeckSelectionViewModel();

  void initWithSections(List<CardSection> sections) {
    if (sections == null) {
      return;
    }
    cardSections = sections;

    indices = List<int>();
    scrollControllers = List<ScrollController>();

    for (var _ in cardSections) {
      scrollControllers.add(ScrollController());
      indices.add(0);
    }

    isLoading = false;
    notifyListeners();
  }

  bool onNotification(
      ScrollNotification notification, BoxConstraints constraints, int index) {
    double cardSize = constraints.maxWidth / 2 + 10;
    if (notification is ScrollUpdateNotification) {
      double offset = scrollControllers[index].offset;
      int cardIndex = offset < 0
          ? 0
          : offset ~/ cardSize + ((offset % cardSize > (cardSize / 2)) ? 1 : 0);

      indices[index] = cardIndex;
    } else if (notification is ScrollEndNotification) {
      Future.delayed(Duration(microseconds: 1), () {
        double target = indices[index] * cardSize;
        scrollControllers[index].animateTo(target,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    }
    notifyListeners();
    return true;
  }

  int getNrCardDecksInSection(int i) => cardSections[i].cardDecks.length;
}
