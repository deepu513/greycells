import 'package:equatable/equatable.dart';

abstract class PageTransitionEvent extends Equatable {
  const PageTransitionEvent();

  @override
  List<Object> get props => [];
}

class TransitionToNextPage extends PageTransitionEvent {}

class TransitionToPreviousPage extends PageTransitionEvent {}
