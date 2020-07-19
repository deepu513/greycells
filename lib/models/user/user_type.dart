import 'package:json_annotation/json_annotation.dart';

enum UserType {
  @JsonValue("VOLUNTEER")
  VOLUNTEER,

  @JsonValue("CONTRIBUTOR")
  CONTRIBUTOR,
}
