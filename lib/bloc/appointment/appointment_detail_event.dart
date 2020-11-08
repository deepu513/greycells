part of 'appointment_detail_bloc.dart';

abstract class AppointmentDetailEvent extends Equatable {
  const AppointmentDetailEvent();

  @override
  List<Object> get props => [];
}

class CancelAppointment extends AppointmentDetailEvent {
  final int appointmentId;
  CancelAppointment(this.appointmentId);
}
