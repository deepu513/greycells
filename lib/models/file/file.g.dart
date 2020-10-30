// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

File _$FileFromJson(Map<String, dynamic> json) {
  return File()
    ..type = json['type'] as String
    ..name = json['url'] as String
    ..id = json['id'] as int;
}

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic>{
      'type': instance.type,
      'url': instance.name,
      'id': instance.id,
    };
