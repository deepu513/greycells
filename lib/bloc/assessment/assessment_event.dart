part of 'assessment_bloc.dart';

abstract class AssessmentEvent {}

class LoadAssessmentTest extends AssessmentEvent {}

class QuestionAnswered extends AssessmentEvent {}

class ShowPreviousQuestion extends AssessmentEvent {}

class TrySelectingOption extends AssessmentEvent {
  final Option option;

  TrySelectingOption(this.option);
}
