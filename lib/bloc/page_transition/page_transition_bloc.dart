import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import './bloc.dart';

class PageTransitionBloc
    extends Bloc<PageTransitionEvent, PageTransitionState> {
  /// Number of pages start from zero.
  final int numberOfPages;
  final int initialPageNumber;

  int _currentPageNumber;

  PageTransitionBloc({@required this.numberOfPages, this.initialPageNumber = 1})
      : super(PageTransitionInitial(initialPageNumber)) {
    _currentPageNumber = initialPageNumber;
  }

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
      if (_currentPageNumber == 1)
        yield PageTransitionReachedLowerLimit(_currentPageNumber);
      else {
        --_currentPageNumber;
        yield PageTransitionToPreviousPage(_currentPageNumber);
      }
    }
  }
}
