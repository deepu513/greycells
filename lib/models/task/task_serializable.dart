import 'package:greycells/models/task/task.dart';
import 'package:greycells/networking/serializable.dart';

class TaskSerializable implements Serializable<Task> {
  @override
  Task fromJson(Map<String, dynamic> json) {
    return Task.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Task item) {
    return item.toJson();
  }

  @override
  List<Task> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<Task> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
