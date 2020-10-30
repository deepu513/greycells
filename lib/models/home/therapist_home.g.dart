// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'therapist_home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TherapistHome _$TherapistHomeFromJson(Map<String, dynamic> json) {
  return TherapistHome()
    ..therapist = json['therapist'] == null
        ? null
        : Therapist.fromJson(json['therapist'] as Map<String, dynamic>)
    ..serverTimestamp = json['serverTimeStamp'] as String
    ..upcomingAppointments = (json['upcomingappointments'] as List)
        ?.map((e) =>
            e == null ? null : Appointment.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TherapistHomeToJson(TherapistHome instance) =>
    <String, dynamic>{
      'therapist': instance.therapist?.toJson(),
      'serverTimeStamp': instance.serverTimestamp,
      'upcomingappointments':
          instance.upcomingAppointments?.map((e) => e?.toJson())?.toList(),
    };
