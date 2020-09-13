// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_option_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveOptionRequest _$SaveOptionRequestFromJson(Map<String, dynamic> json) {
  return SaveOptionRequest()
    ..testTypeId = json['TestTypeId'] as int
    ..questionId = json['QuestionId'] as int
    ..selectedOptionIds =
        (json['OptionMasterIds'] as List)?.map((e) => e as int)?.toList()
    ..score = json['Score'] as int
    ..patientId = json['PatientId'] as int;
}

Map<String, dynamic> _$SaveOptionRequestToJson(SaveOptionRequest instance) =>
    <String, dynamic>{
      'TestTypeId': instance.testTypeId,
      'QuestionId': instance.questionId,
      'OptionMasterIds': instance.selectedOptionIds,
      'Score': instance.score,
      'PatientId': instance.patientId,
    };
