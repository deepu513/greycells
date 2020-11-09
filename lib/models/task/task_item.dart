import 'package:json_annotation/json_annotation.dart';

part 'task_item.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskItem {
  @JsonKey(name: "Title")
  String title;

  @JsonKey(name: "ExpectedCompletionDateTIme")
  String expectedCompletionDateTIme;

  @JsonKey(name: "Description")
  String description;

  @JsonKey(name: "FileId")
  int fIleId;

  @JsonKey(ignore: true)
  String filePath;

  TaskItem();

  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      _$TaskItemFromJson(json);

  Map<String, dynamic> toJson() => _$TaskItemToJson(this);
}
