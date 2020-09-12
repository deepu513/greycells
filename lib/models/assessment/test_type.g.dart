// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestType _$TestTypeFromJson(Map<String, dynamic> json) {
  return TestType()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..isActive = json['isActive'] as bool;
}

Map<String, dynamic> _$TestTypeToJson(TestType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isActive': instance.isActive,
    };
