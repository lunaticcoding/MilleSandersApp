part of 'carddeck_bloc.dart';

@freezed
abstract class CardDeckState with _$CardDeckState{
  const factory CardDeckState.loading([String message]) = Loading;
  const factory CardDeckState.data() = Data;
  const factory CardDeckState.error([String message]) = Error;
}
