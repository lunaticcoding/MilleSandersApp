import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'carddeck_event.dart';
part 'carddeck_state.dart';

class CarddeckBloc extends Bloc<CarddeckEvent, CarddeckState> {
  @override
  CarddeckState get initialState => CarddeckInitial();
  @override
  Stream<CarddeckState> mapEventToState(
    CarddeckEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
