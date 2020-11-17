import 'package:json_annotation/json_annotation.dart';

part 'meeting_type.g.dart';

@JsonSerializable(explicitToJson: true)
class MeetingType {
  String name;
  int id;

  MeetingType();

  factory MeetingType.fromJson(Map<String, dynamic> json) =>
      _$MeetingTypeFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingTypeToJson(this);
}
