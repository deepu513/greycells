// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient()
    ..genderValue = json['Gender'] as int
    ..id = json['CustomerID'] as int
    ..alternativeNumber = json['AlternativeNumber'] as String
    ..profilePicId = json['FileId'] as String
    ..isMinor = json['IsMinor'] as bool
    ..address = json['Address'] == null
        ? null
        : Address.fromJson(json['Address'] as Map<String, dynamic>)
    ..isEligibleForTest = json['isEligibleForTest'] as bool
    ..healthRecord = json['HealthRecord'] == null
        ? null
        : HealthRecord.fromJson(json['HealthRecord'] as Map<String, dynamic>)
    ..medicalRecord = json['MedicalRecord'] == null
        ? null
        : MedicalRecord.fromJson(json['MedicalRecord'] as Map<String, dynamic>)
    ..guardian = json['Guardian'] == null
        ? null
        : Guardian.fromJson(json['Guardian'] as Map<String, dynamic>)
    ..placeOfBirth = json['PlaceOfBirth'] as String
    ..dateOfBirth = json['DateOfBirth'] as String
    ..timeOfBirth = json['TimeOfBirth'] as String;
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'Gender': instance.genderValue,
      'CustomerID': instance.id,
      'AlternativeNumber': instance.alternativeNumber,
      'FileId': instance.profilePicId,
      'IsMinor': instance.isMinor,
      'Address': instance.address?.toJson(),
      'isEligibleForTest': instance.isEligibleForTest,
      'HealthRecord': instance.healthRecord?.toJson(),
      'MedicalRecord': instance.medicalRecord?.toJson(),
      'Guardian': instance.guardian?.toJson(),
      'PlaceOfBirth': instance.placeOfBirth,
      'DateOfBirth': instance.dateOfBirth,
      'TimeOfBirth': instance.timeOfBirth,
    };
