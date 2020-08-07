import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:growthdeck/features/card_deck/data/models/card_model.dart';
import 'package:growthdeck/features/card_deck/domain/entities/card.dart';

import '../../../../fixtures/card_map_fixture.dart';

main() {
  CardModel model;

  setUp(() {
    model = CardModel(cardFixture);
  });

  test('CardModel is a subtype of Card entity', () async {
    expect(model, isA<Card>());
  });

  test('initializes CardModel with valid data from map', () {
    expect(model.text, 'demo text');
    expect(model.categories.length, isNonZero);
    expect(model.color, isNotNull);
  });
}
