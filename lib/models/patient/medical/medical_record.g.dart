// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalRecord _$MedicalRecordFromJson(Map<String, dynamic> json) {
  return MedicalRecord()
    ..patientId = json['PatientId'] as int
    ..fileId = json['FileId'] as int;
}

Map<String, dynamic> _$MedicalRecordToJson(MedicalRecord instance) =>
    <String, dynamic>{
      'PatientId': instance.patientId,
      'FileId': instance.fileId,
    };
