// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Home _$HomeFromJson(Map<String, dynamic> json) {
  return Home()
    ..patient = json['patient'] == null
        ? null
        : Patient.fromJson(json['patient'] as Map<String, dynamic>)
    ..behaviourLastAttemptedQuestion = json['behaviourLastattemtedques'] == null
        ? null
        : Question.fromJson(
            json['behaviourLastattemtedques'] as Map<String, dynamic>)
    ..personalityLastAttemptedQuestion =
        json['personalityLastattemtedques'] == null
            ? null
            : Question.fromJson(
                json['personalityLastattemtedques'] as Map<String, dynamic>)
    ..personalityScore = (json['personalityScore'] as List)
        ?.map(
            (e) => e == null ? null : Score.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..behaviourScore = (json['behaviourScore'] as List)
        ?.map(
            (e) => e == null ? null : Score.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$HomeToJson(Home instance) => <String, dynamic>{
      'patient': instance.patient?.toJson(),
      'behaviourLastattemtedques':
          instance.behaviourLastAttemptedQuestion?.toJson(),
      'personalityLastattemtedques':
          instance.personalityLastAttemptedQuestion?.toJson(),
      'personalityScore':
          instance.personalityScore?.map((e) => e?.toJson())?.toList(),
      'behaviourScore':
          instance.behaviourScore?.map((e) => e?.toJson())?.toList(),
    };
