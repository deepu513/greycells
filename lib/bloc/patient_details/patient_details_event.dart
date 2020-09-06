part of 'patient_details_bloc.dart';

abstract class PatientDetailsEvent {}

class UpdateGuardianRelationship extends PatientDetailsEvent {
  final Relationship relationship;
  String actualValue;

  UpdateGuardianRelationship(this.relationship, {this.actualValue});
}

class UpdateGender extends PatientDetailsEvent {
  final Gender gender;

  UpdateGender(this.gender);
}

class BirthDetailsValidated extends PatientDetailsEvent {}

class HealthDetailsSubmitted extends PatientDetailsEvent {}