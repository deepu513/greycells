// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question()
    ..id = json['id'] as int
    ..sequence = json['sequence'] as int
    ..answerUpperLimit = json['answerUpperLimit'] as int
    ..isActive = json['isActive'] as bool
    ..isLastQuestion = json['isLastQuestion'] as bool
    ..questionText = json['name'] as String
    ..options = (json['optionMaster'] as List)
        ?.map((e) =>
            e == null ? null : Option.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'sequence': instance.sequence,
      'answerUpperLimit': instance.answerUpperLimit,
      'isActive': instance.isActive,
      'isLastQuestion': instance.isLastQuestion,
      'name': instance.questionText,
      'optionMaster': instance.options?.map((e) => e?.toJson())?.toList(),
    };
