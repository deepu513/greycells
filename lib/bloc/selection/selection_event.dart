import 'package:equatable/equatable.dart';

abstract class SelectionEvent<T> extends Equatable {
  @override
  List<Object> get props => [];
}

class SelectionSelectItem<T> extends SelectionEvent<T> {
  final T item;

  SelectionSelectItem({this.item});

  @override
  List<Object> get props => [item];

  @override
  bool get stringify => true;
}
