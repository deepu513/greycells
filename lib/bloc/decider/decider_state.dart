part of 'decider_bloc.dart';

@immutable
abstract class DeciderState {}

class DeciderInitial extends DeciderState {}

class NextPageDecided extends DeciderState {
  final String routeName;
  final AssessmentTestArguments assessmentTestArguments;
  final Home homeData;

  NextPageDecided(this.routeName, this.homeData, {this.assessmentTestArguments});
}

class NextPageDeciding extends DeciderState {}

class DeciderError extends DeciderState {}
