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

class CompleteAppointment extends AppointmentDetailEvent {
  final int appointmentId;
  CompleteAppointment(this.appointmentId);
}

class StartAppointment extends AppointmentDetailEvent {
  final String displayName;
  final String subject;
  final String patientName;
  final String therapistName;

  StartAppointment(
      {@required this.displayName,
      @required this.subject,
      @required this.patientName,
      @required this.therapistName});
}
