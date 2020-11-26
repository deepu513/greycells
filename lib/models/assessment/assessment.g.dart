// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assessment _$AssessmentFromJson(Map<String, dynamic> json) {
  return Assessment()
    ..id = json['id'] as int
    ..reportFileName = json['reportFileName'] as String
    ..createdDate = json['createdDate'] as String;
}

Map<String, dynamic> _$AssessmentToJson(Assessment instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'reportFileName': instance.reportFileName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('createdDate', instance.createdDate);
  return val;
}
