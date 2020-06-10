import 'package:growthdeck/features/card_deck/domain/entities/deck.dart';
import 'package:growthdeck/features/card_deck/domain/entities/section.dart';

class SectionModel extends Section {
  final String name;
  final List<Deck> decks;

  SectionModel({this.name, this.decks});
}
