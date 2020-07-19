import 'package:equatable/equatable.dart';

abstract class SelectionState<T> extends Equatable {
  @override
  List<Object> get props => [];
}

class SelectionInitial<T> extends SelectionState<T> {}

class SelectionItemSelected<T> extends SelectionState<T> {
  final T selectedItem;

  SelectionItemSelected({this.selectedItem});

  @override
  List<Object> get props => [selectedItem];

  @override
  bool get stringify => true;
}
