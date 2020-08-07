import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'carddeck_event.dart';
part 'carddeck_state.dart';
part 'carddeck_state.freezed.dart';

class CardDeckBloc extends Bloc<CarddeckEvent, CardDeckState> {
  CardDeckBloc(CardDeckState initialState) : super(initialState);

  @override
  Stream<CardDeckState> mapEventToState(
    CarddeckEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
