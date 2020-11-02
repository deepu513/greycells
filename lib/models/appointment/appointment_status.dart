import 'package:json_annotation/json_annotation.dart';

enum AppointmentStatus {
  @JsonValue(0)
  upcoming,

  @JsonValue(1)
  completed,
  
  @JsonValue(2)
  cancelled
}
