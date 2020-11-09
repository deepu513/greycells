// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task()
    ..title = json['Title'] as String
    ..appointmentId = json['AppointmentId'] as int
    ..patientId = json['PatientId'] as int
    ..therapistId = json['TherapistId'] as int
    ..taskItems = (json['TaskItems'] as List)
        ?.map((e) =>
            e == null ? null : TaskItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'Title': instance.title,
      'AppointmentId': instance.appointmentId,
      'PatientId': instance.patientId,
      'TherapistId': instance.therapistId,
      'TaskItems': instance.taskItems?.map((e) => e?.toJson())?.toList(),
    };
