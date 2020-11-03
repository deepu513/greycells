import 'package:json_annotation/json_annotation.dart';

part 'timeslot_request.g.dart';

@JsonSerializable(explicitToJson: true)
class TimeslotRequest {
  int therapistId;
  String date;

  TimeslotRequest();

  factory TimeslotRequest.fromJson(Map<String, dynamic> json) =>
      _$TimeslotRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TimeslotRequestToJson(this);
}
