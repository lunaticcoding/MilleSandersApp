import 'package:flutter_test/flutter_test.dart';
import 'package:growthdeck/viewmodels/deck_selection_viewmodel.dart';

import '../mockData.dart';

void main() {
  DeckSelectionViewModel model;

  setUp(() {
    model = DeckSelectionViewModel()..initWithSections(sectionsMockWithDecks);
  });

  test('has sections', () {
    expect(model.cardSections, isNotEmpty);
  });

  test('sections have decks', () {
    expect(model.cardSections.first.cardDecks, isNotEmpty);
  });

  test('has same number of indices as sections', () {
    expect(model.indices.length, model.cardSections.length);
  });

  test('has same number of controllers as sections', () {
    expect(model.scrollControllers.length, model.cardSections.length);
  });

  test('returns correct number of decks in section', () {
    expect(model.getNrCardDecksInSection(0), 2);
  });
}
