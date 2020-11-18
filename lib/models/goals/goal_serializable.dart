import 'package:greycells/models/goals/goal.dart';
import 'package:greycells/networking/serializable.dart';

class GoalSerializable implements Serializable<Goal> {
  @override
  Goal fromJson(Map<String, dynamic> json) {
    return Goal.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Goal item) {
    return item.toJson();
  }

  @override
  List<Goal> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<Goal> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
