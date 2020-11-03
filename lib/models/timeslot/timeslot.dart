import 'package:json_annotation/json_annotation.dart';

part 'timeslot.g.dart';

@JsonSerializable(explicitToJson: true)
class Timeslot {
  String startTime;
  String endTime;
  int id;

  Timeslot();

  factory Timeslot.fromJson(Map<String, dynamic> json) =>
      _$TimeslotFromJson(json);
  Map<String, dynamic> toJson() => _$TimeslotToJson(this);
}
