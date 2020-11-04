import 'package:json_annotation/json_annotation.dart';

part 'meeting_duration.g.dart';

@JsonSerializable(explicitToJson: true)
class MeetingDuration {
  int duration;

  MeetingDuration();

  factory MeetingDuration.fromJson(Map<String, dynamic> json) =>
      _$MeetingDurationFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingDurationToJson(this);
}
