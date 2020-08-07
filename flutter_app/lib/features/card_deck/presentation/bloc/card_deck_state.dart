part of 'card_deck_bloc.dart';

@freezed
abstract class CardDeckState with _$CardDeckState {
  const factory CardDeckState.loading() = Loading;
  const factory CardDeckState.sectionState({@required List<Section> sections}) =
      SectionState;
  const factory CardDeckState.deckState({@required List<Deck> sections}) =
      DeckState;
  const factory CardDeckState.error([String message]) = Error;
}
