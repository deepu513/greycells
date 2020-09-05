part of 'patient_details_bloc.dart';

abstract class PatientDetailsEvent {}

class AddBirthDetails extends PatientDetailsEvent {}

class AddProfilePicture extends PatientDetailsEvent {}

class AddHealthDetails extends PatientDetailsEvent {}

class AddGuardianDetails extends PatientDetailsEvent {}

class AddAddressDetails extends PatientDetailsEvent {}

class AddMedicalRecordDetails extends PatientDetailsEvent {}