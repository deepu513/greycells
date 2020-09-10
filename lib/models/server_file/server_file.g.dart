// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerFile _$ServerFileFromJson(Map<String, dynamic> json) {
  return ServerFile()
    ..fileId = json['fileId'] as int
    ..name = json['name'] as String;
}

Map<String, dynamic> _$ServerFileToJson(ServerFile instance) =>
    <String, dynamic>{
      'fileId': instance.fileId,
      'name': instance.name,
    };
