import 'package:json_annotation/json_annotation.dart';

enum UserType {
  @JsonValue(0)
  patient,

  @JsonValue(1)
  therapist,
}
