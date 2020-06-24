import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';
import 'package:growthdeck/features/card_deck/domain/entities/deck.dart';
import 'package:growthdeck/features/card_deck/domain/entities/section.dart';
import 'package:growthdeck/features/card_deck/domain/repositories/card_data_repository.dart';
import 'package:growthdeck/features/card_deck/domain/usecases/get_sections.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCardDataRepository extends Mock implements CardDataRepository {}

main() {
  GetSections usecase;
  CardDataRepository mockCardDataRepository;

  setUp(() {
    mockCardDataRepository = MockCardDataRepository();
    usecase = GetSections(mockCardDataRepository);
  });

  final List<Section> tSections = [
    Section(name: "section1", decks: [
      Deck(
        name: 'test',
        filters: ['1', '2'],
        icon: MilleSanders.advice,
        color: Color(0xff324354),
      )
    ])
  ];

  test('should return list of sections when call to repository successful',
      () async {
    when(mockCardDataRepository.getSections())
        .thenAnswer((_) => Stream.value([Section(name: "section1", decks: [])]));

    final expected = [Section(name: "section1", decks: [])];

    expect(usecase(), emits(expected));
    verify(mockCardDataRepository.getSections());
    verifyNoMoreInteractions(mockCardDataRepository);
  });
}
