import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class SelectionBloc<T> extends Bloc<SelectionEvent<T>, SelectionState<T>> {

  SelectionBloc() : super(SelectionInitial<T>());

  @override
  Stream<SelectionState<T>> mapEventToState(
    SelectionEvent<T> event,
  ) async* {
    if (event is SelectionSelectItem<T>) {
      yield SelectionItemSelected<T>(selectedItem: event.item);
    }
  }
}
