import 'package:json_annotation/json_annotation.dart';

part 'charge.g.dart';

@JsonSerializable(explicitToJson: true)
class MeetingCharge {
  int amount;
  int chargeId;
  int meetingTypeId;
  String meetingType;

  MeetingCharge();

  factory MeetingCharge.fromJson(Map<String, dynamic> json) => _$MeetingChargeFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingChargeToJson(this);
}
