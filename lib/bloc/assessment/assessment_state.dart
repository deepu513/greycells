part of 'assessment_bloc.dart';

@immutable
abstract class AssessmentState {}

class AssessmentInitial extends AssessmentState {}

class AssessmentTestLoading extends AssessmentState {}

class AssessmentError extends AssessmentState {}

class ShowQuestion extends AssessmentState {
  final int totalQuestions;
  final Question currentQuestion;

  ShowQuestion(this.currentQuestion, this.totalQuestions);
}

class OptionSelected extends AssessmentState {}

class OptionDeselected extends AssessmentState {}

class MaxOptionsSelected extends AssessmentState {}
