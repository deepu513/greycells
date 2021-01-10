part of 'appointment_detail_bloc.dart';

abstract class AppointmentDetailEvent extends Equatable {
  const AppointmentDetailEvent();

  @override
  List<Object> get props => [];
}

class CancelAppointment extends AppointmentDetailEvent {
  final int appointmentId;
  final int notifierId;
  final bool shouldRefund;
  CancelAppointment(this.appointmentId, this.notifierId, this.shouldRefund);
}

class CompleteAppointment extends AppointmentDetailEvent {
  final int appointmentId;
  final int notifierId;
  CompleteAppointment(this.appointmentId, this.notifierId);
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
