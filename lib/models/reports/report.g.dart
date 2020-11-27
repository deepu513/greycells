// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) {
  return Report()
    ..patientId = json['patientId'] as int
    ..assessmentId = json['assessmentId'] as int
    ..fileName = json['filePath'] as String
    ..id = json['id'] as int
    ..createdDate = json['createdDate'] as String;
}

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'patientId': instance.patientId,
      'assessmentId': instance.assessmentId,
      'filePath': instance.fileName,
      'id': instance.id,
      'createdDate': instance.createdDate,
    };
