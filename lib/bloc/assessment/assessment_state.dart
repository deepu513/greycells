part of 'assessment_bloc.dart';

@immutable
abstract class AssessmentState {}

class AssessmentInitial extends AssessmentState {}

class AssessmentQuestionsLoading extends AssessmentState {}

class AssessmentError extends AssessmentState {}

class AssessmentQuestionsLoaded extends AssessmentState {}
