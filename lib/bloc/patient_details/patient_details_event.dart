part of 'patient_details_bloc.dart';

abstract class PatientDetailsEvent {}

class AddBirthDetails extends PatientDetailsEvent {}

class AddProfilePicture extends PatientDetailsEvent {}

class AddHealthDetails extends PatientDetailsEvent {}

class AddGuardianDetails extends PatientDetailsEvent {}

class AddAddressDetails extends PatientDetailsEvent {}

class AddMedicalRecordDetails extends PatientDetailsEvent {}

class UpdateGuardianRelationship extends PatientDetailsEvent {
  final Relationship relationship;
  String actualValue;

  UpdateGuardianRelationship(this.relationship, {this.actualValue});
}

class UpdateGender extends PatientDetailsEvent {
  final Gender gender;

  UpdateGender(this.gender);
}