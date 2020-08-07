import 'package:flutter/foundation.dart';
import 'package:growthdeck/features/card_deck/domain/entities/deck.dart';

class Section {
  final String name;
  List<Deck> decks;

  Section({
    @required this.name,
    @required this.decks,
  });
}
