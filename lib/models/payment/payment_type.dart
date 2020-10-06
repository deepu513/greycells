import 'package:json_annotation/json_annotation.dart';

enum PaymentType {
@JsonValue(0)
ASSESSMENT,

@JsonValue(1)
APPOINTMENT,
}