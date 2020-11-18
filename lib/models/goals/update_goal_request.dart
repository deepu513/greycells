import 'package:json_annotation/json_annotation.dart';

part 'update_goal_request.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateGoalRequest {
  @JsonKey(name: "PatientId")
  int patientId;

  @JsonKey(name: "PatientGoalMappingId")
  int patientGoalMappingId;

  @JsonKey(name: "Status")
  int status;

  UpdateGoalRequest();

  factory UpdateGoalRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateGoalRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateGoalRequestToJson(this);
}
