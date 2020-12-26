// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletedGoal _$CompletedGoalFromJson(Map<String, dynamic> json) {
  return CompletedGoal()
    ..goalId = json['goalId'] as int
    ..patientId = json['patientId'] as int
    ..id = json['id'] as int;
}

Map<String, dynamic> _$CompletedGoalToJson(CompletedGoal instance) =>
    <String, dynamic>{
      'goalId': instance.goalId,
      'patientId': instance.patientId,
      'id': instance.id,
    };
