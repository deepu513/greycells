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
  final val = <String, dynamic>{
    'id': instance.id,
    'title': instance.title,
    'expectedCompletionDateTIme': instance.expectedCompletionDateTIme,
    'description': instance.description,
    'fIleId': instance.fIleId,
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('file', instance.file?.toJson());
  return val;
}
