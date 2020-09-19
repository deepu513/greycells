part of 'assessment_bloc.dart';

abstract class AssessmentEvent {}

class UpdateCurrentQuestionNumber extends AssessmentEvent {
  final int currentQuestionNumber;

  UpdateCurrentQuestionNumber(this.currentQuestionNumber);
}

class LoadAssessmentTest extends AssessmentEvent {
  final int testTypeId;

  LoadAssessmentTest(this.testTypeId);
}

class QuestionAnswered extends AssessmentEvent {}

class ShowPreviousQuestion extends AssessmentEvent {}

class TrySelectingOption extends AssessmentEvent {
  final Option option;

  TrySelectingOption(this.option);
}
