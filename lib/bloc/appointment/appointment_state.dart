part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentsLoading extends AppointmentState {}

class AppointmentsEmpty extends AppointmentState {}

class AppointmentsLoaded extends AppointmentState {
  final List<Appointment> allAppointments;
  AppointmentsLoaded(this.allAppointments);
}

class AppointmentsLoadError extends AppointmentState {
  final String error;
  AppointmentsLoadError(this.error);
}
