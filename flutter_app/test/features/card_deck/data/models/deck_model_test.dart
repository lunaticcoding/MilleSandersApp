import 'package:flutter_test/flutter_test.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';
import 'package:growthdeck/features/card_deck/data/models/deck_model.dart';
import 'package:growthdeck/features/card_deck/domain/entities/deck.dart';

import '../../../../fixtures/deck_map_fixture.dart';

main() {
  DeckModel model;

  setUp(() {
    model = DeckModel.fromMap(deckFixture);
  });

  test('DeckModel is a subtype of Deck entity', () {
    expect(model, isA<Deck>());
  });

  test('initializes DeckModel with valid data from map', () {
    expect(model.name, 'name');
    expect(model.color, isNotNull);
    expect(model.icon, MilleSanders.advice);
    expect(model.filters.length, isNonZero);
  });
}
