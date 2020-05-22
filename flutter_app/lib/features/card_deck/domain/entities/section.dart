import 'package:equatable/equatable.dart';
import 'package:growthdeck/models/Decks.dart';

class Section extends Equatable {
  @override
  List<Object> get props => [name]..addAll(cardDecks);

  String name;
  List<CardDeck> cardDecks;
//   Section.fromData(dynamic json) {
//     name = json['sectionName'] as String;
//     cardDecks = List<CardDeck>();
//     json['decks']
//         .forEach((dynamic deck) => cardDecks.add(CardDeck.fromData(deck)));
//   }
}
