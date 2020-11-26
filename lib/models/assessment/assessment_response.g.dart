// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssessmentResponse _$AssessmentResponseFromJson(Map<String, dynamic> json) {
  return AssessmentResponse()
    ..assessment = json['assessment'] == null
        ? null
        : Assessment.fromJson(json['assessment'] as Map<String, dynamic>)
    ..behaviourScore = (json['beh_score'] as List)
        ?.map(
            (e) => e == null ? null : Score.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..personalityScore = (json['per_score'] as List)
        ?.map(
            (e) => e == null ? null : Score.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..allPersonalityScore = (json['allPer_score'] as List)
        ?.map(
            (e) => e == null ? null : Score.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AssessmentResponseToJson(AssessmentResponse instance) =>
    <String, dynamic>{
      'assessment': instance.assessment?.toJson(),
      'beh_score': instance.behaviourScore?.map((e) => e?.toJson())?.toList(),
      'per_score': instance.personalityScore?.map((e) => e?.toJson())?.toList(),
      'allPer_score':
          instance.allPersonalityScore?.map((e) => e?.toJson())?.toList(),
    };
