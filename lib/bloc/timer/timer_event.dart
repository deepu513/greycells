part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class StartTimerIfNeeded extends TimerEvent {
  final DateTime serverDateTime;
  final DateTime appointmentDateTime;

  StartTimerIfNeeded(this.serverDateTime, this.appointmentDateTime);
}

class StartTimer extends TimerEvent {}

class StopTimer extends TimerEvent {}
