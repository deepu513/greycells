import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greycells/time_watcher.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer _timer;

  TimerBloc() : super(TimerInitial());

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is StartTimerIfNeeded) {
      print("Before timewatched add ${event.serverDateTime}");
      DateTime currentDateTime =
          event.serverDateTime.add(TimeWatcher.getInstance().elapsedDuration());
      print("After timewatcher add $currentDateTime");
      DateTime appointmentDateTime = event.appointmentDateTime;
      Duration differenceDuration =
          appointmentDateTime.difference(currentDateTime);

      if (differenceDuration.isNegative) {
        yield AppointmentInPast();
      } else if (differenceDuration.inDays > 1) {
        yield TimerUpdated("${differenceDuration.inDays} Days");
      } else if (differenceDuration.inDays <= 1) {
        if (differenceDuration.inHours > 1) {
          yield TimerUpdated("${differenceDuration.inHours} Hours");
        } else if (differenceDuration.inHours <= 1) {
          if (differenceDuration.inMinutes > 10) {
            yield TimerUpdated("${differenceDuration.inMinutes} Minutes");
          } else if (differenceDuration.inMinutes <= 10) {
            int remainingSeconds = differenceDuration.inSeconds;
            _timer = Timer.periodic(Duration(seconds: 1), (timer) async* {
              if (remainingSeconds < 1) {
                timer.cancel();
              } else {
                --remainingSeconds;
                yield (TimerUpdated(
                    "${(remainingSeconds / 60) % 60} : ${remainingSeconds % 60}"));
              }
            });
          }
        }
      }
    }
  }

  @override
  Future<void> close() {
    if (_timer != null) _timer.cancel();
    return super.close();
  }
}
