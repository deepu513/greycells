// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_appointment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAppointmentRequest _$CreateAppointmentRequestFromJson(
    Map<String, dynamic> json) {
  return CreateAppointmentRequest()
    ..therapistId = json['therapistId'] as int
    ..patientId = json['patientId'] as int
    ..duration = json['duration'] as int
    ..comments = json['comments'] as String
    ..timeslotId = json['timeslotId'] as int
    ..paymentId = json['Paymentid'] as int
    ..meetingTypeId = json['MeetingTypeId'] as int;
}

Map<String, dynamic> _$CreateAppointmentRequestToJson(
        CreateAppointmentRequest instance) =>
    <String, dynamic>{
      'therapistId': instance.therapistId,
      'patientId': instance.patientId,
      'duration': instance.duration,
      'comments': instance.comments,
      'timeslotId': instance.timeslotId,
      'Paymentid': instance.paymentId,
      'MeetingTypeId': instance.meetingTypeId,
    };
