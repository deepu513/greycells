part of 'patient_details_edit_bloc.dart';

abstract class PatientDetailsEditEvent extends Equatable {
  const PatientDetailsEditEvent();

  @override
  List<Object> get props => [];
}

class UpdateGuardianRelationship extends PatientDetailsEditEvent {
  final Relationship relationship;

  UpdateGuardianRelationship(this.relationship);
}

class UpdateGender extends PatientDetailsEditEvent {
  final Gender gender;

  UpdateGender(this.gender);
}

class HealthDetailsSubmitted extends PatientDetailsEditEvent {}

class AddressValidated extends PatientDetailsEditEvent {}

class GuardianHasSameAddress extends PatientDetailsEditEvent {}

class GuardianNotHasSameAddress extends PatientDetailsEditEvent {}

class PersonalDetailsValidated extends PatientDetailsEditEvent {}

class AddMedicalRecordFile extends PatientDetailsEditEvent {
  final PickedFile pickedFile;

  AddMedicalRecordFile(this.pickedFile);
}

class RemoveMedicalRecordFile extends PatientDetailsEditEvent {
  final PickedFile pickedFile;

  RemoveMedicalRecordFile(this.pickedFile);
}

class UploadPatientDetails extends PatientDetailsEditEvent {}
