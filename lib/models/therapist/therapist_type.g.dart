// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'therapist_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TherapistType _$TherapistTypeFromJson(Map<String, dynamic> json) {
  return TherapistType()
    ..name = json['name'] as String
    ..expertise = json['expertise'] as String
    ..specialisation = json['specialisation'] as String
    ..id = json['id'] as int;
}

Map<String, dynamic> _$TherapistTypeToJson(TherapistType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'expertise': instance.expertise,
      'specialisation': instance.specialisation,
      'id': instance.id,
    };
