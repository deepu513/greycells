part of 'assessment_bloc.dart';

abstract class AssessmentEvent {}

class QuestionAnswered extends AssessmentEvent {}

class ShowPreviousQuestion extends AssessmentEvent {}

class ShowNextQuestion extends AssessmentEvent {}

class SelectOption extends AssessmentEvent {
  final Option option;

  SelectOption(this.option);
}
