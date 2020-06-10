import 'package:growthdeck/features/card_deck/domain/entities/deck.dart';
import 'package:meta/meta.dart';

class Section {
  final String name;
  final List<Deck> decks;

  Section({@required this.name, @required this.decks});
}
