// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disorder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Disorder _$DisorderFromJson(Map<String, dynamic> json) {
  return Disorder()
    ..name = json['name'] as String
    ..duration = json['duration'] as int
    ..id = json['id'] as int;
}

Map<String, dynamic> _$DisorderToJson(Disorder instance) => <String, dynamic>{
      'name': instance.name,
      'duration': instance.duration,
      'id': instance.id,
    };
