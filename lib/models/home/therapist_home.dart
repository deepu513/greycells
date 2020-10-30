import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/therapist/therapist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'therapist_home.g.dart';

@JsonSerializable(explicitToJson: true)
class TherapistHome {
  @JsonKey(name: "therapist")
  Therapist therapist;

  @JsonKey(name: "serverTimeStamp")
  String serverTimestamp;

  @JsonKey(name: "upcomingappointments")
  List<Appointment> upcomingAppointments;

  TherapistHome();

  factory TherapistHome.fromJson(Map<String, dynamic> json) =>
      _$TherapistHomeFromJson(json);
  Map<String, dynamic> toJson() => _$TherapistHomeToJson(this);
}
