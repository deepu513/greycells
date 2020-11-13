part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

class TimerInitial extends TimerState {}

class TimerUpdated extends TimerState {
  final String timeToAppointment;
  TimerUpdated(this.timeToAppointment);
}

class AppointmentInPast extends TimerState {}

class TimerFinished extends TimerState {}
