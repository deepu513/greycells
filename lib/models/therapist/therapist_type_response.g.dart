// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'therapist_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TherapistTypeResponse _$TherapistTypeResponseFromJson(
    Map<String, dynamic> json) {
  return TherapistTypeResponse()
    ..therapytypes = (json['therapytypes'] as List)
        ?.map((e) => e == null
            ? null
            : TherapistType.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TherapistTypeResponseToJson(
        TherapistTypeResponse instance) =>
    <String, dynamic>{
      'therapytypes': instance.therapytypes?.map((e) => e?.toJson())?.toList(),
    };
