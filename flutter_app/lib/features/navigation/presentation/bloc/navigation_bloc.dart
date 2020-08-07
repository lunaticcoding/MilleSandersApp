import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'navigation_event.dart';
part 'navigation_state.dart';

// TODO import .freezed. <- auto generated file

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(NavigationState initialState) : super(initialState);

  @override
  Stream<NavigationState> mapEventToState(
      NavigationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
