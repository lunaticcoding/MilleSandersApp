import 'package:growthdeck/features/card_deck/domain/entities/deck.dart';
import 'package:growthdeck/features/card_deck/domain/entities/section.dart';

abstract class CardDataRepository {
  Stream<List<Section>> getSections();
  Stream<Deck> getDeck(String name);
}
