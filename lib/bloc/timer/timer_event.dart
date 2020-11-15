part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  final List properties;

  const TimerEvent([this.properties]);

  @override
  List<Object> get props => [properties];
}

class InitiateTimer extends TimerEvent {
  final DateTime serverDateTime;
  final DateTime eventDateTime;

  InitiateTimer(this.serverDateTime, this.eventDateTime);
}

class Start extends TimerEvent {
  final int duration;

  Start({@required this.duration}) : super([duration]);

  @override
  String toString() => "Start { duration: $duration }";
}

class Pause extends TimerEvent {
  @override
  String toString() => "Pause";
}

class Resume extends TimerEvent {
  @override
  String toString() => "Resume";
}

class Reset extends TimerEvent {
  @override
  String toString() => "Reset";
}

class Tick extends TimerEvent {
  final int duration;

  Tick({@required this.duration}) : super([duration]);

  @override
  String toString() => "Tick { duration: $duration }";
}
