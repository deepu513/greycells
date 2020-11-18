import 'package:greycells/models/goals/update_goal_request.dart';
import 'package:greycells/networking/serializable.dart';

class UpdateGoalRequestSerializable implements Serializable<UpdateGoalRequest> {
  @override
  UpdateGoalRequest fromJson(Map<String, dynamic> json) {
    return UpdateGoalRequest.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(UpdateGoalRequest item) {
    return item.toJson();
  }

  @override
  List<UpdateGoalRequest> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<UpdateGoalRequest> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
