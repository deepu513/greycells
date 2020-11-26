import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/timeslot/timeslot.dart';
import 'package:greycells/models/timeslot/timeslot_request.dart';
import 'package:greycells/models/timeslot/timeslot_response.dart';
import 'package:greycells/repository/appointment_repository.dart';
import 'package:greycells/extensions.dart';

part 'timeslot_event.dart';
part 'timeslot_state.dart';

class TimeslotBloc extends Bloc<TimeslotEvent, TimeslotState> {
  AppointmentRepository repository;
  TimeslotBloc() : super(TimeslotInitial()) {
    repository = AppointmentRepository();
  }

  @override
  Stream<TimeslotState> mapEventToState(
    TimeslotEvent event,
  ) async* {
    if (event is LoadTimeslotsForTherapist) {
      yield TimeslotsLoading();

      try {
        TimeslotRequest timeslotRequest = TimeslotRequest()
          ..date = event.selectedDate
          ..therapistId = event.therapistId;

        TimeslotResponse response =
            await repository.getAvailableTimeslots(timeslotRequest);

        if (response != null &&
            response.timeslots != null &&
            response.timeslots.isNotEmpty) {
          DateTime currentDateTime = DateTime.now();
          DateTime selectedDate = event.selectedDate.fromddMMyyyy();
          List<Timeslot> validTimeslots = List();
          response.timeslots.forEach((timeslot) {
            DateTime aTime = timeslot.startTime.timeAsDate();
            DateTime fullDateTime = DateTime(selectedDate.year,
                selectedDate.month, selectedDate.day, aTime.hour, aTime.minute);

            if (currentDateTime.isBefore(fullDateTime)) {
              validTimeslots.add(timeslot);
            }
          });
          if (validTimeslots.isNotEmpty)
            yield TimeslotsLoaded(response.timeslots);
          else
            yield TimeslotsEmpty();
        } else if (response != null &&
            response.timeslots != null &&
            response.timeslots.isEmpty) {
          yield TimeslotsEmpty();
        } else
          yield TimeslotLoadError(ErrorMessages.GENERIC_ERROR_MESSAGE);
      } catch (e) {
        yield TimeslotLoadError(ErrorMessages.GENERIC_ERROR_MESSAGE);
      }
    }
  }
}
