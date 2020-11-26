part of 'assessment_score_bloc.dart';

abstract class AssessmentScoreEvent extends Equatable {
  const AssessmentScoreEvent();

  @override
  List<Object> get props => [];
}

class LoadAssessmentScores extends AssessmentScoreEvent {
  final int patientId;

  LoadAssessmentScores(this.patientId);
}
