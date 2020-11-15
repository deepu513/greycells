part of 'appointment_detail_bloc.dart';

abstract class AppointmentDetailState extends Equatable {
  const AppointmentDetailState();

  @override
  List<Object> get props => [];
}

class AppointmentDetailInitial extends AppointmentDetailState {}

class AppointmentCancelling extends AppointmentDetailState {}

class AppointmentCancelled extends AppointmentDetailState {}

class AppointmentCancelFailed extends AppointmentDetailState {
  final String error;
  AppointmentCancelFailed(this.error);
}

class AppointmentStartFailed extends AppointmentDetailState {}

class AppointmentEnded extends AppointmentDetailState {}
