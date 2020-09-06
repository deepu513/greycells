// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthRecord _$HealthRecordFromJson(Map<String, dynamic> json) {
  return HealthRecord()
    ..weightInKg = json['Width'] as int
    ..heightInCm = json['Height'] as int
    ..bloodGroup = json['BloodGroup'] as int
    ..bmi = json['BMI'] as int
    ..medicalHistory = json['MedicalHistory'] as String;
}

Map<String, dynamic> _$HealthRecordToJson(HealthRecord instance) =>
    <String, dynamic>{
      'Width': instance.weightInKg,
      'Height': instance.heightInCm,
      'BloodGroup': instance.bloodGroup,
      'BMI': instance.bmi,
      'MedicalHistory': instance.medicalHistory,
    };
