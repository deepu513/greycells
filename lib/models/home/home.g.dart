// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Home _$HomeFromJson(Map<String, dynamic> json) {
  return Home()
    ..id = json['id'] as int
    ..email = json['email'] as String
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..mobileNumber = json['mobileNumber'] as String
    ..userType = json['userType'] as String
    ..patient = json['patient'] == null
        ? null
        : Patient.fromJson(json['patient'] as Map<String, dynamic>)
    ..behaviourLastAttemptedQuestion =
        json['behaviourLastAttemptedQuestion'] == null
            ? null
            : Question.fromJson(
                json['behaviourLastAttemptedQuestion'] as Map<String, dynamic>)
    ..personalityLastAttemptedQuestion =
        json['personalityLastAttemptedQuestion'] == null
            ? null
            : Question.fromJson(json['personalityLastAttemptedQuestion']
                as Map<String, dynamic>)
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
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobileNumber': instance.mobileNumber,
      'userType': instance.userType,
      'patient': instance.patient?.toJson(),
      'behaviourLastAttemptedQuestion':
          instance.behaviourLastAttemptedQuestion?.toJson(),
      'personalityLastAttemptedQuestion':
          instance.personalityLastAttemptedQuestion?.toJson(),
      'personalityScore':
          instance.personalityScore?.map((e) => e?.toJson())?.toList(),
      'behaviourScore':
          instance.behaviourScore?.map((e) => e?.toJson())?.toList(),
    };
