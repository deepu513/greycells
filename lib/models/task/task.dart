import 'package:greycells/models/task/task_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task {
  @JsonKey(name: "Title")
  String title;

  @JsonKey(name: "AppointmentId")
  int appointmentId;

  @JsonKey(name: "PatientId")
  int patientId;

  @JsonKey(name: "TherapistId")
  int therapistId;

  @JsonKey(name: "TaskItems")
  List<TaskItem> taskItems;

  Task();

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
