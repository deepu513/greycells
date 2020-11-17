import 'package:greycells/models/appointment/meeting_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment_charge.g.dart';

@JsonSerializable(explicitToJson: true)
class AppointmentCharge {
  int meetingTypeId;
  MeetingType meetingType;
  int amount;
  int id;

  AppointmentCharge();

  factory AppointmentCharge.fromJson(Map<String, dynamic> json) =>
      _$AppointmentChargeFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentChargeToJson(this);
}
