import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'carddeck_event.dart';
part 'carddeck_state.dart';
// TODO import .freezed. <- auto generated file

class CardDeckBloc extends Bloc<CarddeckEvent, CarddeckState> {
  CardDeckBloc(CarddeckState initialState) : super(initialState);

  @override
  Stream<CarddeckState> mapEventToState(
    CarddeckEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
