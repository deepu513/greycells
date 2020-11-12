// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItem _$TaskItemFromJson(Map<String, dynamic> json) {
  return TaskItem()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..expectedCompletionDateTIme = json['expectedCompletionDateTIme'] as String
    ..description = json['description'] as String
    ..fIleId = json['fIleId'] as int
    ..status = json['status'] as int
    ..file = json['file'] == null
        ? null
        : File.fromJson(json['file'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TaskItemToJson(TaskItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['title'] = instance.title;
  val['expectedCompletionDateTIme'] = instance.expectedCompletionDateTIme;
  val['description'] = instance.description;
  writeNotNull('fIleId', instance.fIleId);
  writeNotNull('status', instance.status);
  writeNotNull('file', instance.file?.toJson());
  return val;
}
