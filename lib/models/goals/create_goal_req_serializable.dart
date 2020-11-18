import 'package:greycells/networking/serializable.dart';
import 'create_goal_request.dart';

class CreateGoalRequestSerializable implements Serializable<CreateGoalRequest> {
  @override
  CreateGoalRequest fromJson(Map<String, dynamic> json) {
    return CreateGoalRequest.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(CreateGoalRequest item) {
    return item.toJson();
  }

  @override
  List<CreateGoalRequest> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<CreateGoalRequest> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
