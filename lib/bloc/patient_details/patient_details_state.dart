part of 'patient_details_bloc.dart';

@immutable
abstract class PatientDetailsState {}

class PatientDetailsInitial extends PatientDetailsState {}

class GuardianRelationshipUpdated extends PatientDetailsState {
  final Relationship relationship;

  GuardianRelationshipUpdated(this.relationship);
}

class GenderUpdated extends PatientDetailsState {
  final Gender updatedGender;

  GenderUpdated(this.updatedGender);
}

class StateOK extends PatientDetailsState {}