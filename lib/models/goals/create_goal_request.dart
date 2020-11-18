import 'package:json_annotation/json_annotation.dart';

part 'create_goal_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateGoalRequest {
  @JsonKey(name: "PatientId")
  int patientId;

  @JsonKey(name: "GoalTypeId")
  int goalTypeId;

  CreateGoalRequest();

  factory CreateGoalRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateGoalRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateGoalRequestToJson(this);
}
