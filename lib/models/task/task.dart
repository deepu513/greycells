import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/models/task/task_item.dart';
import 'package:greycells/models/therapist/therapist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task {
  String title;

  int appointmentId;

  int patientId;

  int therapistId;

  @JsonKey(includeIfNull: false)
  Therapist therapist;

  @JsonKey(includeIfNull: false)
  Patient patient;

  List<TaskItem> taskItems;

  Task();

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
