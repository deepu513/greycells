// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) {
  return Option()
    ..optionText = json['text'] as String
    ..questionId = json['questionId'] as int
    ..score = json['score'] as int
    ..id = json['id'] as int
    ..isActive = json['isActive'] as bool;
}

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'text': instance.optionText,
      'questionId': instance.questionId,
      'score': instance.score,
      'id': instance.id,
      'isActive': instance.isActive,
    };
