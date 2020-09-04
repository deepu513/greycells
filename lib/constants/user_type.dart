import 'package:json_annotation/json_annotation.dart';

enum UserType {
  @JsonValue(0)
  PATIENT,

  @JsonValue(1)
  THERAPIST,
}
