import 'package:greycells/models/timeslot/timeslot.dart';
import 'package:json_annotation/json_annotation.dart';

part 'timeslot_response.g.dart';

@JsonSerializable(explicitToJson: true)
class TimeslotResponse {
  @JsonKey(name: "avaliableTimeSlots")
  List<Timeslot> timeslots;

  TimeslotResponse();

  factory TimeslotResponse.fromJson(Map<String, dynamic> json) =>
      _$TimeslotResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$TimeslotResponseToJson(this);
}
