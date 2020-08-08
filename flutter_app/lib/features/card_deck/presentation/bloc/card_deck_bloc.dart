import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:growthdeck/features/card_deck/domain/entities/deck.dart';
import 'package:growthdeck/features/card_deck/domain/entities/section.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_deck_event.dart';
part 'card_deck_state.dart';
part 'card_deck_bloc.freezed.dart';

class CardDeckBloc extends Bloc<CardDeckEvent, CardDeckState> {
  CardDeckBloc(CardDeckState initialState) : super(initialState) {
    this.add(CardDeckEvent.loadData());
  }

  @override
  Stream<CardDeckState> mapEventToState(
    CardDeckEvent event,
  ) async* {
    yield* event.map(
      loadData: (e) async* {
        yield CardDeckState.loading();
        yield CardDeckState.error("jolo");
      },
    );
  }
}
