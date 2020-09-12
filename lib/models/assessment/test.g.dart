// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) {
  return Test()
    ..testType = json['testType'] == null
        ? null
        : TestType.fromJson(json['testType'] as Map<String, dynamic>)
    ..questions = (json['questions'] as List)
        ?.map((e) =>
            e == null ? null : Question.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'testType': instance.testType?.toJson(),
      'questions': instance.questions?.map((e) => e?.toJson())?.toList(),
    };
