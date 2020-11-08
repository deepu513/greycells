import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/repository/appointment_repository.dart';

part 'appointment_detail_event.dart';
part 'appointment_detail_state.dart';

class AppointmentDetailBloc
    extends Bloc<AppointmentDetailEvent, AppointmentDetailState> {
  AppointmentRepository repository;
  AppointmentDetailBloc() : super(AppointmentDetailInitial()) {
    repository = AppointmentRepository();
  }

  @override
  Stream<AppointmentDetailState> mapEventToState(
    AppointmentDetailEvent event,
  ) async* {
    if (event is CancelAppointment) {
      yield AppointmentCancelling();
      try {
        bool result = await repository.updateAppointment(
            event.appointmentId, AppointmentStatus.cancelled);

        if (result != null && result == true) {
          yield AppointmentCancelled();
        } else
          yield AppointmentCancelFailed(ErrorMessages.GENERIC_ERROR_MESSAGE);
      } catch (e) {
        yield AppointmentCancelFailed(ErrorMessages.GENERIC_ERROR_MESSAGE);
      }
    }
  }
}
