import 'package:flutter_test/flutter_test.dart';
import 'package:growthdeck/features/card_deck/data/models/section_model.dart';
import 'package:growthdeck/features/card_deck/domain/entities/deck.dart';
import 'package:growthdeck/features/card_deck/domain/entities/section.dart';

int main() {
  SectionModel model = SectionModel();

  test('SectionModel is a subtype of Section entity', () async {
    expect(model, isA<Section>());
  });

  group('from Firestore', () {
    test('should return a valid model for valid input data', () {
      model = SectionModel(
        name: "test",
        decks: [
          Deck(),
        ],
      );
    });
  });
}
