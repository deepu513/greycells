// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return Appointment()
    ..therapistId = json['therapistId'] as int
    ..patientId = json['patientId'] as int
    ..duration = json['duration'] as int
    ..paymentId = json['paymentId'] as int
    ..chargeId = json['chargeId'] as int
    ..id = json['id'] as int
    ..timeSlotId = json['timeSlotId'] as int
    ..meetingTypeId = json['meetingTypeId'] as int
    ..status = json['status'] as int
    ..paymentID = json['paymentID'] as int
    ..date = json['date'] as String
    ..comments = json['comments'] as String
    ..therapist = json['therapist'] == null
        ? null
        : Therapist.fromJson(json['therapist'] as Map<String, dynamic>)
    ..patient = json['patient'] == null
        ? null
        : Patient.fromJson(json['patient'] as Map<String, dynamic>)
    ..charge = json['charge'] == null
        ? null
        : MeetingCharge.fromJson(json['charge'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'therapistId': instance.therapistId,
      'patientId': instance.patientId,
      'duration': instance.duration,
      'paymentId': instance.paymentId,
      'chargeId': instance.chargeId,
      'id': instance.id,
      'timeSlotId': instance.timeSlotId,
      'meetingTypeId': instance.meetingTypeId,
      'status': instance.status,
      'paymentID': instance.paymentID,
      'date': instance.date,
      'comments': instance.comments,
      'therapist': instance.therapist?.toJson(),
      'patient': instance.patient?.toJson(),
      'charge': instance.charge?.toJson(),
    };
