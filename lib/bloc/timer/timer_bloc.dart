import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:greycells/time_watcher.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer _timer;

  StreamSubscription<int> _tickerSubscription;

  TimerBloc() : super(Ready(0, ""));

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is InitiateTimer) {
      DateTime currentDateTime =
          event.serverDateTime.add(TimeWatcher.getInstance().elapsedDuration());

      Duration differenceDuration = event.eventDateTime
          .subtract(Duration(minutes: 5))
          .difference(currentDateTime);

      if (differenceDuration.isNegative) {
        if (differenceDuration.inMinutes <= 60) {
          /*
           * This is to make sure that the person is able to join 
           * the meeting 60 minutes after the scheduled time.
           */
          yield Finished();
        } else
          yield TimeInPast();
      } else {
        yield* _mapStartToState(Start(duration: differenceDuration.inSeconds));
      }
    } else if (event is Start) {
      yield* _mapStartToState(event);
    } else if (event is Pause) {
      yield* _mapPauseToState(event);
    } else if (event is Resume) {
      yield* _mapResumeToState(event);
    } else if (event is Reset) {
      yield* _mapResetToState(event);
    } else if (event is Tick) {
      yield* _mapTickToState(event);
    }
  }

  Stream<int> tick({int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }

  Stream<TimerState> _mapStartToState(Start start) async* {
    yield Running(start.duration, _getReadableDuration(state.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = tick(ticks: start.duration).listen(
      (duration) {
        add(Tick(duration: duration));
      },
    );
  }

  Stream<TimerState> _mapPauseToState(Pause pause) async* {
    if (state is Running) {
      _tickerSubscription?.pause();
      yield Paused(state.duration, _getReadableDuration(state.duration));
    }
  }

  Stream<TimerState> _mapResumeToState(Resume pause) async* {
    if (state is Paused) {
      _tickerSubscription?.resume();
      yield Running(state.duration, _getReadableDuration(state.duration));
    }
  }

  Stream<TimerState> _mapResetToState(Reset reset) async* {
    _tickerSubscription?.cancel();
    yield Ready(0, "");
  }

  Stream<TimerState> _mapTickToState(Tick tick) async* {
    yield tick.duration > 0
        ? Running(tick.duration, _getReadableDuration(state.duration))
        : Finished();
  }

  String _getReadableDuration(int seconds) {
    Duration remainingDuration = Duration(seconds: seconds);

    if (remainingDuration.inDays > 1) {
      return "${remainingDuration.inDays} days";
    }

    if (remainingDuration.inDays <= 1) {
      if (remainingDuration.inHours >= 1) {
        return "${remainingDuration.inHours} hour(s)";
      } else if (remainingDuration.inHours < 1) {
        if (remainingDuration.inMinutes >= 10) {
          return "${remainingDuration.inMinutes} minutes";
        } else if (remainingDuration.inMinutes < 10) {
          int remainingSeconds = remainingDuration.inSeconds;
          return "${(((remainingSeconds / 60) % 60).toInt().toString().padLeft(2, '0'))} : ${(remainingSeconds % 60).toString().padLeft(2, '0')} minutes";
        }
      }
    }

    return "";
  }

  @override
  Future<void> close() {
    if (_timer != null) _timer.cancel();
    return super.close();
  }
}
