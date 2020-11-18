// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalType _$GoalTypeFromJson(Map<String, dynamic> json) {
  return GoalType()
    ..id = json['id'] as int
    ..patientGoalMappingId = json['patientGoalMappingId'] as int
    ..name = json['name'] as String
    ..status = json['status'] as String;
}

Map<String, dynamic> _$GoalTypeToJson(GoalType instance) => <String, dynamic>{
      'id': instance.id,
      'patientGoalMappingId': instance.patientGoalMappingId,
      'name': instance.name,
      'status': instance.status,
    };
