// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_goal_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateGoalRequest _$UpdateGoalRequestFromJson(Map<String, dynamic> json) {
  return UpdateGoalRequest()
    ..patientId = json['PatientId'] as int
    ..patientGoalMappingId = json['PatientGoalMappingId'] as int
    ..status = json['Status'] as int;
}

Map<String, dynamic> _$UpdateGoalRequestToJson(UpdateGoalRequest instance) =>
    <String, dynamic>{
      'PatientId': instance.patientId,
      'PatientGoalMappingId': instance.patientGoalMappingId,
      'Status': instance.status,
    };
