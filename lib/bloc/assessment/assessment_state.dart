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

class NoMoreQuestions extends AssessmentState {}

class OptionSelected extends AssessmentState {
  final int totalQuestions;
  final Question currentQuestion;

  OptionSelected(this.currentQuestion, this.totalQuestions);
}

class OptionDeselected extends AssessmentState {
  final int totalQuestions;
  final Question currentQuestion;

  OptionDeselected(this.currentQuestion, this.totalQuestions);
}

class MaxOptionsSelected extends AssessmentState {}

class AlreadyAnswered extends AssessmentState {}

class SavingSelectedOption extends AssessmentState {
  final int totalQuestions;
  final Question currentQuestion;

  SavingSelectedOption(this.currentQuestion, this.totalQuestions);
}

class ErrorWhileSavingSelectedOption extends AssessmentState {
  final int totalQuestions;
  final Question currentQuestion;

  ErrorWhileSavingSelectedOption(this.currentQuestion, this.totalQuestions);
}
