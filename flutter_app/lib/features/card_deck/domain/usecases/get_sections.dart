import 'package:dartz/dartz.dart';
import 'package:growthdeck/core/error/failures.dart';
import 'package:growthdeck/features/card_deck/domain/entities/section.dart';
import 'package:growthdeck/features/card_deck/domain/repositories/cardDataRepository.dart';

class GetSections {
  final CardDataRepository repository;
  GetSections(this.repository);

  Future<Either<Failure, List<Section>>> call() async =>
      await repository.getSections();
}
