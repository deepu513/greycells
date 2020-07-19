import 'package:equatable/equatable.dart';

abstract class PageTransitionState extends Equatable {
  final int currentPageNumber;

  const PageTransitionState(this.currentPageNumber);

  @override
  List<Object> get props => [currentPageNumber];
}

class PageTransitionInitial extends PageTransitionState {
  const PageTransitionInitial(currentPageNumber) : super(currentPageNumber);
}

class PageTransitionToNextPage extends PageTransitionState {
  const PageTransitionToNextPage(currentPageNumber)
      : super(currentPageNumber);
}

class PageTransitionToPreviousPage extends PageTransitionState {
  const PageTransitionToPreviousPage(currentPageNumber)
      : super(currentPageNumber);
}

class PageTransitionReachedUpperLimit extends PageTransitionState {
  const PageTransitionReachedUpperLimit(currentPageNumber)
      : super(currentPageNumber);
}

class PageTransitionReachedLowerLimit extends PageTransitionState {
  const PageTransitionReachedLowerLimit(currentPageNumber)
      : super(currentPageNumber);
}
