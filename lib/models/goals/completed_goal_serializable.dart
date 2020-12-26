import 'package:greycells/models/goals/completed_goal.dart';
import 'package:greycells/networking/serializable.dart';

class CompletedGoalSerializable implements Serializable<CompletedGoal> {
  @override
  CompletedGoal fromJson(Map<String, dynamic> json) {
    return CompletedGoal.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(CompletedGoal item) {
    return item.toJson();
  }

  @override
  List<CompletedGoal> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<CompletedGoal> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
