// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..appointmentId = json['appointmentId'] as int
    ..patientId = json['patientId'] as int
    ..therapistId = json['therapistId'] as int
    ..therapist = json['therapist'] == null
        ? null
        : Therapist.fromJson(json['therapist'] as Map<String, dynamic>)
    ..patient = json['patient'] == null
        ? null
        : Patient.fromJson(json['patient'] as Map<String, dynamic>)
    ..createdDate = json['createddate'] as String
    ..taskItems = (json['taskItems'] as List)
        ?.map((e) =>
            e == null ? null : TaskItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TaskToJson(Task instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['title'] = instance.title;
  writeNotNull('appointmentId', instance.appointmentId);
  writeNotNull('patientId', instance.patientId);
  writeNotNull('therapistId', instance.therapistId);
  writeNotNull('therapist', instance.therapist?.toJson());
  writeNotNull('patient', instance.patient?.toJson());
  writeNotNull('createddate', instance.createdDate);
  val['taskItems'] = instance.taskItems?.map((e) => e?.toJson())?.toList();
  return val;
}
