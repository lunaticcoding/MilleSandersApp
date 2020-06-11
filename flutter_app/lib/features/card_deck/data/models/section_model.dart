import 'package:growthdeck/features/card_deck/domain/entities/section.dart';

import 'deck_model.dart';

class SectionModel extends Section {
  final String name;
  final List<DeckModel> decks;

  SectionModel.fromMap(Map<String, dynamic> section)
      : this.name = section['name'],
        this.decks = section['decks']
            .map<DeckModel>((deck) => DeckModel.fromMap(deck))
            .toList();
}
