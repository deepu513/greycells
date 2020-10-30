// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientHome _$PatientHomeFromJson(Map<String, dynamic> json) {
  return PatientHome()
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
        ?.toList()
    ..upcomingAppointments = (json['upcomingAppoinments'] as List)
        ?.map((e) =>
            e == null ? null : Appointment.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..availableTherapists = (json['avaliableThrapist'] as List)
        ?.map((e) =>
            e == null ? null : Therapist.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..serverTimestamp = json['serverTimeStamp'] as String;
}

Map<String, dynamic> _$PatientHomeToJson(PatientHome instance) =>
    <String, dynamic>{
      'patient': instance.patient?.toJson(),
      'behaviourLastattemtedques':
          instance.behaviourLastAttemptedQuestion?.toJson(),
      'personalityLastattemtedques':
          instance.personalityLastAttemptedQuestion?.toJson(),
      'personalityScore':
          instance.personalityScore?.map((e) => e?.toJson())?.toList(),
      'behaviourScore':
          instance.behaviourScore?.map((e) => e?.toJson())?.toList(),
      'upcomingAppoinments':
          instance.upcomingAppointments?.map((e) => e?.toJson())?.toList(),
      'avaliableThrapist':
          instance.availableTherapists?.map((e) => e?.toJson())?.toList(),
      'serverTimeStamp': instance.serverTimestamp,
    };
