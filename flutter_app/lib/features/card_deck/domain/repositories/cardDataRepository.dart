import 'package:dartz/dartz.dart';
import 'package:growthdeck/core/error/failures.dart';
import 'package:growthdeck/features/cardDeck/domain/entities/deck.dart';
import 'package:growthdeck/features/cardDeck/domain/entities/section.dart';

abstract class CardDataRepository {
  Future<Either<Failure, List<Section>>> getSections();
  Future<Either<Failure, Deck>> getDeck(String name);
}
