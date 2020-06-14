import 'package:equatable/equatable.dart';
import 'package:growthdeck/features/card_deck/domain/entities/deck.dart';
import 'package:meta/meta.dart';

class Section extends Equatable {
  final String name;
  final List<Deck> decks;

  Section({@required this.name, @required this.decks});

  @override
  List<Object> get props => [name, decks];
}
