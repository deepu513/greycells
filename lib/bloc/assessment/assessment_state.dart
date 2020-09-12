part of 'assessment_bloc.dart';

@immutable
abstract class AssessmentState {}

class AssessmentInitial extends AssessmentState {}

class AssessmentTestLoading extends AssessmentState {}

class AssessmentError extends AssessmentState {}

class AssessmentTestLoaded extends AssessmentState {
  final Test test;
  AssessmentTestLoaded(this.test);
}

class OptionSelected extends AssessmentState {}

class OptionDeselected extends AssessmentState {}

class MaxOptionsSelected extends AssessmentState {}
