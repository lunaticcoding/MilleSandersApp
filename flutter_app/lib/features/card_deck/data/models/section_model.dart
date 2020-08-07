import 'package:growthdeck/features/card_deck/domain/entities/section.dart';

import 'deck_model.dart';

class SectionModel extends Section {
  SectionModel(Map<String, dynamic> section)
      : super(
            name: section['name'],
            decks: section['decks']
                .map<DeckModel>((deck) => DeckModel(deck))
                .toList());
}
