// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItem _$TaskItemFromJson(Map<String, dynamic> json) {
  return TaskItem()
    ..title = json['Title'] as String
    ..expectedCompletionDateTIme = json['ExpectedCompletionDateTIme'] as String
    ..description = json['Description'] as String
    ..fIleId = json['FileId'] as int;
}

Map<String, dynamic> _$TaskItemToJson(TaskItem instance) => <String, dynamic>{
      'Title': instance.title,
      'ExpectedCompletionDateTIme': instance.expectedCompletionDateTIme,
      'Description': instance.description,
      'FileId': instance.fIleId,
    };
