// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_patient_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePatientRequest _$UpdatePatientRequestFromJson(Map<String, dynamic> json) {
  return UpdatePatientRequest()
    ..id = json['id'] as int
    ..fileId = json['FileId'] as int
    ..user = json['customer'] == null
        ? null
        : User.fromJson(json['customer'] as Map<String, dynamic>)
    ..healthRecord = json['healthRecord'] == null
        ? null
        : HealthRecord.fromJson(json['healthRecord'] as Map<String, dynamic>)
    ..address = json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>)
    ..guardian = json['guardian'] == null
        ? null
        : Guardian.fromJson(json['guardian'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdatePatientRequestToJson(
        UpdatePatientRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'FileId': instance.fileId,
      'customer': instance.user?.toJson(),
      'healthRecord': instance.healthRecord?.toJson(),
      'address': instance.address?.toJson(),
      'guardian': instance.guardian?.toJson(),
    };
