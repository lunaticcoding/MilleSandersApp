import 'package:dartz/dartz.dart';
import 'package:growthdeck/core/error/failures.dart';
import 'package:growthdeck/features/card_deck/domain/entities/deck.dart';
import 'package:growthdeck/features/card_deck/domain/entities/section.dart';

abstract class CardDataRepository {
  Future<Either<Failure, List<Section>>> getSections();
  Future<Either<Failure, Deck>> getDeck(String name);
}
