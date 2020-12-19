part of 'patient_details_edit_bloc.dart';

@immutable
abstract class PatientDetailsEditState {
}

class PatientDetailsEditInitial extends PatientDetailsEditState {}

class OtherRelationshipSelected extends PatientDetailsEditState {}

class GenderUpdated extends PatientDetailsEditState {
  final Gender updatedGender;

  GenderUpdated(this.updatedGender);
}

class GuardianAddressUpdated extends PatientDetailsEditState {
  final bool hasSameAddress;

  GuardianAddressUpdated(this.hasSameAddress);
}

class PatientDetailsUploaded extends PatientDetailsEditState {
  final String message;

  PatientDetailsUploaded(this.message);
}

class ErrorWhileUploading extends PatientDetailsEditState {}

class PatientUploadProgress extends PatientDetailsEditState {
  final String message;

  PatientUploadProgress(this.message);
}

class StateOK extends PatientDetailsEditState {}
