import 'package:json_annotation/json_annotation.dart';
part 'completed_goal.g.dart';

@JsonSerializable(explicitToJson: true)
class CompletedGoal {
  int goalId;
  int patientId;
  int id;

  CompletedGoal();

  factory CompletedGoal.fromJson(Map<String, dynamic> json) =>
      _$CompletedGoalFromJson(json);
  Map<String, dynamic> toJson() => _$CompletedGoalToJson(this);
}
