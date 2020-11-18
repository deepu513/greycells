// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_goal_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGoalRequest _$CreateGoalRequestFromJson(Map<String, dynamic> json) {
  return CreateGoalRequest()
    ..patientId = json['PatientId'] as int
    ..goalTypeId = json['GoalTypeId'] as int;
}

Map<String, dynamic> _$CreateGoalRequestToJson(CreateGoalRequest instance) =>
    <String, dynamic>{
      'PatientId': instance.patientId,
      'GoalTypeId': instance.goalTypeId,
    };
