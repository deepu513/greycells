import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/repository/appointment_repository.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:convert/convert.dart';

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
            event.appointmentId, AppointmentStatus.cancelled, event.notifierId);

        if (result != null && result == true) {
          yield AppointmentCancelled();
        } else
          yield AppointmentCancelFailed(ErrorMessages.GENERIC_ERROR_MESSAGE);
      } catch (e) {
        yield AppointmentCancelFailed(ErrorMessages.GENERIC_ERROR_MESSAGE);
      }
    }

    if (event is CompleteAppointment) {
      yield AppointmentCompleting();
      try {
        bool result = await repository.updateAppointment(
            event.appointmentId, AppointmentStatus.completed, event.notifierId);

        if (result != null && result == true) {
          yield AppointmentCompleted();
        } else
          yield AppointmentCancelFailed(ErrorMessages.GENERIC_ERROR_MESSAGE);
      } catch (e) {
        yield AppointmentCancelFailed(ErrorMessages.GENERIC_ERROR_MESSAGE);
      }
    }

    if (event is StartAppointment) {
      try {
        yield AppointmentStarting();
        var str = event.patientName + event.therapistName;
        var bytes = utf8.encode(str);
        var base64Str = hex.encode(bytes);

        var options = JitsiMeetingOptions()
          ..room = base64Str // Required, spaces will be trimmed
          ..subject = event.subject
          ..userDisplayName = event.displayName
          ..featureFlags = {
            FeatureFlagEnum.INVITE_ENABLED: false,
            FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
            FeatureFlagEnum.CALENDAR_ENABLED: false,
            FeatureFlagEnum.CLOSE_CAPTIONS_ENABLED: false,
            FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
            FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false
          };

        await JitsiMeet.joinMeeting(options);
        yield AppointmentEnded();
      } catch (error) {
        print("Error while joining call $error");
        yield AppointmentStartFailed();
      }
    }
  }
}
