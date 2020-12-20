part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class LoadAppointments extends AppointmentEvent {
  final AppointmentStatus status;
  final TherapistType therapistType;
  final int pageNumber;

  LoadAppointments(this.pageNumber,
      {this.status, this.therapistType});
}
