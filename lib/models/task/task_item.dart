import 'package:greycells/models/file/file.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_item.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskItem {
  @JsonKey(includeIfNull: false)
  int id;

  String title;

  String expectedCompletionDateTIme;

  String description;

  @JsonKey(includeIfNull: false)
  int fIleId;

  @JsonKey(includeIfNull: false)
  int status;

  @JsonKey(includeIfNull: false)
  File file;

  @JsonKey(ignore: true)
  String filePath;

  @JsonKey(ignore: true)
  String readableDate;

  TaskItem();

  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      _$TaskItemFromJson(json);

  Map<String, dynamic> toJson() => _$TaskItemToJson(this);
}
