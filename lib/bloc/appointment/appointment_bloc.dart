import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/appointment/all_appointment_response.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/models/therapist/therapist_type.dart';
import 'package:greycells/repository/appointment_repository.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentRepository repository;
  AppointmentStatus status;

  AppointmentBloc() : super(AppointmentInitial()) {
    repository = AppointmentRepository();
  }

  @override
  Stream<AppointmentState> mapEventToState(
    AppointmentEvent event,
  ) async* {
    if (event is LoadAppointments) {
      if (event.status != null) status = event.status;

      yield AppointmentsLoading();
      try {
        AllAppointmentsResponse response =
            await repository.getAllAppointments(event.pageNumber, status.index);

        if (response != null &&
            response.appointments != null &&
            response.appointments.isNotEmpty) {
          if (event.therapistType != null) {
            List<Appointment> filteredAppointments = List();
            response.appointments.forEach((appointment) {
              if (appointment.therapist.therapistType.id ==
                  event.therapistType.id) {
                filteredAppointments.add(appointment);
              }
            });
            yield AppointmentsLoaded(filteredAppointments);
          } else
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
