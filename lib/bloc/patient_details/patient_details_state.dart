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

class GuardianAddressUpdated extends PatientDetailsState {
  final bool hasSameAddress;

  GuardianAddressUpdated(this.hasSameAddress);
}

class PatientDetailsUploaded extends PatientDetailsState {}

class ErrorWhileUploading extends PatientDetailsState {}

class PatientUploadProgress extends PatientDetailsState {
  final String message;

  PatientUploadProgress(this.message);
}

class StateOK extends PatientDetailsState {}
