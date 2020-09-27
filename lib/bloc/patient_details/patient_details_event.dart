part of 'patient_details_bloc.dart';

abstract class PatientDetailsEvent {}

class UpdateGuardianRelationship extends PatientDetailsEvent {
  final Relationship relationship;

  UpdateGuardianRelationship(this.relationship);
}

class UpdateGender extends PatientDetailsEvent {
  final Gender gender;

  UpdateGender(this.gender);
}

class BirthDetailsValidated extends PatientDetailsEvent {}

class HealthDetailsSubmitted extends PatientDetailsEvent {}

class AddressValidated extends PatientDetailsEvent {}

class GuardianHasSameAddress extends PatientDetailsEvent {}

class GuardianNotHasSameAddress extends PatientDetailsEvent {}

class AddMedicalRecordFile extends PatientDetailsEvent {
  final PickedFile pickedFile;

  AddMedicalRecordFile(this.pickedFile);
}

class RemoveMedicalRecordFile extends PatientDetailsEvent {
  final PickedFile pickedFile;

  RemoveMedicalRecordFile(this.pickedFile);
}

class UploadPatientDetails extends PatientDetailsEvent {}
