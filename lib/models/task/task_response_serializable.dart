import 'package:greycells/models/task/task_response.dart';
import 'package:greycells/networking/serializable.dart';

class TaskResponseSerializable implements Serializable<TaskResponse> {
  @override
  TaskResponse fromJson(Map<String, dynamic> json) {
    return TaskResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(TaskResponse item) {
    return item.toJson();
  }

  @override
  List<TaskResponse> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<TaskResponse> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
