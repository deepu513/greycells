part of 'assessment_score_bloc.dart';

abstract class AssessmentScoreState extends Equatable {
  const AssessmentScoreState();
  
  @override
  List<Object> get props => [];
}

class AssessmentScoreInitial extends AssessmentScoreState {}


class AssessmentScoreLoading extends AssessmentScoreState {}

class AssessmentScoreLoaded extends AssessmentScoreState {
  final List<AssessmentResponse> assessmentScores;

  AssessmentScoreLoaded(this.assessmentScores);
}


class AssessmentScoreError extends AssessmentScoreState {}

class AssessmentScoreEmpty extends AssessmentScoreState {}
