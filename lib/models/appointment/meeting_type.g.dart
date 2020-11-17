// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingType _$MeetingTypeFromJson(Map<String, dynamic> json) {
  return MeetingType()
    ..name = json['name'] as String
    ..id = json['id'] as int;
}

Map<String, dynamic> _$MeetingTypeToJson(MeetingType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };
