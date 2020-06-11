import 'package:flutter_test/flutter_test.dart';
import 'package:growthdeck/features/card_deck/data/models/section_model.dart';
import 'package:growthdeck/features/card_deck/domain/entities/section.dart';

import '../../../../fixtures/section_map_fixture.dart';

main() {
  SectionModel model;

  setUp(() {
    model = SectionModel.fromMap(sectionFixture);
  });

  test('SectionModel is a subtype of Section entity', () async {
    expect(model, isA<Section>());
  });

  test('initializes SectionModel with valid data from map', () {
    expect(model.name, 'sectionName');
    expect(model.decks.length, 2);
  });
}
