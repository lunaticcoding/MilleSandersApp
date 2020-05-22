import 'package:dartz/dartz.dart';
import 'package:growthdeck/core/error/failures.dart';
import 'package:growthdeck/features/cardDeck/domain/entities/section.dart';
import 'package:growthdeck/features/cardDeck/domain/repositories/cardDataRepository.dart';

class GetSections {
  final CardDataRepository repository;
  GetSections(this.repository);

  Future<Either<Failure, List<Section>>> call() async =>
      await repository.getSections();
}
