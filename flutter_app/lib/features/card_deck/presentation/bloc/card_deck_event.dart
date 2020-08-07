part of 'card_deck_bloc.dart';

@freezed
abstract class CardDeckEvent with _$CardDeckEvent{
  const factory CardDeckEvent.loadData() = _LoadData;
}
