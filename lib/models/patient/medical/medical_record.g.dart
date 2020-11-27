// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalRecord _$MedicalRecordFromJson(Map<String, dynamic> json) {
  return MedicalRecord()
    ..patientId = json['PatientId'] as int
    ..fileId = json['fileId'] as int
    ..file = json['file'] == null
        ? null
        : File.fromJson(json['file'] as Map<String, dynamic>)
    ..id = json['id'] as int;
}

Map<String, dynamic> _$MedicalRecordToJson(MedicalRecord instance) {
  final val = <String, dynamic>{
    'PatientId': instance.patientId,
    'fileId': instance.fileId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('file', instance.file?.toJson());
  writeNotNull('id', instance.id);
  return val;
}
