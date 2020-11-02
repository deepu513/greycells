import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/appointment/all_appointment_response.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/repository/appointment_repository.dart';
import 'package:greycells/view/pages/all_appointments.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentRepository repository;
  AppointmentBloc() : super(AppointmentInitial()) {
    repository = AppointmentRepository();
  }

  @override
  Stream<AppointmentState> mapEventToState(
    AppointmentEvent event,
  ) async* {
    if (event is LoadAppointments) {
      yield AppointmentsLoading();
      try {
        AllAppointmentsResponse response = await repository.getAllAppointments(
            event.pageNumber, event.status.index);

        if (response != null &&
            response.appointments != null &&
            response.appointments.isNotEmpty) {
          yield AppointmentsLoaded(response.appointments);
        } else if (response != null &&
            response.appointments != null &&
            response.appointments.isEmpty) {
          yield AppointmentsEmpty();
        } else
          yield AppointmentsLoadError(ErrorMessages.GENERIC_ERROR_MESSAGE);
      } catch (e) {
        yield AppointmentsLoadError(ErrorMessages.GENERIC_ERROR_MESSAGE);
      }
    }
  }
}
