import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class PageTransitionBloc
    extends Bloc<PageTransitionEvent, PageTransitionState> {
  final int numberOfPages;
  final int initialPageNumber;

  int _currentPageNumber;

  PageTransitionBloc({this.numberOfPages, this.initialPageNumber = 0}) {
    _currentPageNumber = initialPageNumber;
  }

  @override
  PageTransitionState get initialState =>
      PageTransitionInitial(initialPageNumber);

  @override
  Stream<PageTransitionState> mapEventToState(
    PageTransitionEvent event,
  ) async* {
    if (event is TransitionToNextPage) {
      if (_currentPageNumber == numberOfPages)
        yield PageTransitionReachedUpperLimit(_currentPageNumber);
      else {
        ++_currentPageNumber;
        yield PageTransitionToNextPage(_currentPageNumber);
      }
    }

    if (event is TransitionToPreviousPage) {
      if (_currentPageNumber == 0)
        yield PageTransitionReachedLowerLimit(_currentPageNumber);
      else {
        --_currentPageNumber;
        yield PageTransitionToPreviousPage(_currentPageNumber);
      }
    }
  }
}
