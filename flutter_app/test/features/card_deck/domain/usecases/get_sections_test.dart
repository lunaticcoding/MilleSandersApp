import 'package:dartz/dartz.dart';
import 'package:growthdeck/features/cardDeck/domain/entities/section.dart';
import 'package:growthdeck/features/cardDeck/domain/repositories/cardDataRepository.dart';
import 'package:growthdeck/features/cardDeck/domain/usecases/get_sections.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCardDataRepository extends Mock implements CardDataRepository {}

void main() {
  GetSections usecase;
  CardDataRepository mockCardDataRepository;

  setUp(() {
    mockCardDataRepository = MockCardDataRepository();
    usecase = GetSections(mockCardDataRepository);
  });

  final List<Section> tSections = [Section()];

  test('should return list of sections when call to repository successful',
      () async {
    when(mockCardDataRepository.getSections())
        .thenAnswer((_) async => Right([Section()]));

    final result = (await usecase()).getOrElse(() => throw Exception(
        'Failure object was returned instead of Right([Sections])'));

    expect(result, tSections);
    verify(mockCardDataRepository.getSections());
    verifyNoMoreInteractions(mockCardDataRepository);
  });
}
