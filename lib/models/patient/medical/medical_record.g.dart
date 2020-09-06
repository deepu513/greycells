// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalRecord _$MedicalRecordFromJson(Map<String, dynamic> json) {
  return MedicalRecord()
    ..type = json['Type'] as String
    ..fileUrl = json['FileUrl'] as String
    ..fileType = json['FileType'] as String
    ..description = json['Description'] as String;
}

Map<String, dynamic> _$MedicalRecordToJson(MedicalRecord instance) =>
    <String, dynamic>{
      'Type': instance.type,
      'FileUrl': instance.fileUrl,
      'FileType': instance.fileType,
      'Description': instance.description,
    };
