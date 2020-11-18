import 'package:greycells/models/goals/goal_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goal.g.dart';

@JsonSerializable(explicitToJson: true)
class Goal {
  int id;
  String name;
  List<GoalType> goalsTypes;

  Goal();
  
  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
