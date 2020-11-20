part of 'patient_bloc.dart';

abstract class PatientState extends Equatable {
  const PatientState();

  @override
  List<Object> get props => [];
}

class PatientInitial extends PatientState {}

class Loaded extends PatientState {
  final List<Patient> patients;

  Loaded(this.patients);
}

class Loading extends PatientState {}

class Empty extends PatientState {}

class Error extends PatientState {
  final String error;
  Error(this.error);
}
