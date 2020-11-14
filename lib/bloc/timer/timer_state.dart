part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;
  final String readableDuration;

  const TimerState(this.duration, this.readableDuration);

  @override
  List<Object> get props => [duration, readableDuration];
}

class Ready extends TimerState {
  Ready(int duration, String readableDuration)
      : super(duration, readableDuration);

  @override
  String toString() =>
      'Ready { duration: $duration readableDuration: $readableDuration}';
}

class Paused extends TimerState {
  Paused(int duration, String readableDuration)
      : super(duration, readableDuration);

  @override
  String toString() =>
      'Paused { duration: $duration readableDuration: $readableDuration}';
}

class Running extends TimerState {
  Running(int duration, String readableDuration)
      : super(duration, readableDuration);

  @override
  String toString() =>
      'Running { duration: $duration readableDuration: $readableDuration}';
}

class Finished extends TimerState {
  Finished() : super(0, "");

  @override
  String toString() => 'Finished';
}

class TimeInPast extends TimerState {
  TimeInPast() : super(0, "");
  
  @override
  String toString() => 'TimeInPast';
}
