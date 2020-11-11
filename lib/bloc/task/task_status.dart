import 'package:json_annotation/json_annotation.dart';

enum TaskStatus {
  @JsonValue(0)
  pending,

  @JsonValue(1)
  complete,

  @JsonKey(ignore: true)
  overdue
}
