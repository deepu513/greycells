// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthRecord _$HealthRecordFromJson(Map<String, dynamic> json) {
  return HealthRecord()
    ..weightInKg = json['width'] as int
    ..heightInCm = HealthRecord._heightFromJson(json['height'] as String)
    ..bloodGroup = json['bloodGroup'] as int
    ..bmi = json['bmi'] as int
    ..medicalHistory = json['medicalHistory'] as String;
}

Map<String, dynamic> _$HealthRecordToJson(HealthRecord instance) =>
    <String, dynamic>{
      'width': instance.weightInKg,
      'height': HealthRecord._heightToJson(instance.heightInCm),
      'bloodGroup': instance.bloodGroup,
      'bmi': instance.bmi,
      'medicalHistory': instance.medicalHistory,
    };
