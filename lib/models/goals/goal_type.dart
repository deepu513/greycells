import 'package:json_annotation/json_annotation.dart';

part 'goal_type.g.dart';

@JsonSerializable(explicitToJson: true)
class GoalType {
  int id;
  int patientGoalMappingId;
  String name;
  String status;

  GoalType();

  factory GoalType.fromJson(Map<String, dynamic> json) =>
      _$GoalTypeFromJson(json);

  Map<String, dynamic> toJson() => _$GoalTypeToJson(this);
}
