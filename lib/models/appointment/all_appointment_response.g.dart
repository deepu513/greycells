// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_appointment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllAppointmentsResponse _$AllAppointmentsResponseFromJson(
    Map<String, dynamic> json) {
  return AllAppointmentsResponse()
    ..appointments = (json['upappointments'] as List)
        ?.map((e) =>
            e == null ? null : Appointment.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AllAppointmentsResponseToJson(
        AllAppointmentsResponse instance) =>
    <String, dynamic>{
      'upappointments':
          instance.appointments?.map((e) => e?.toJson())?.toList(),
    };
