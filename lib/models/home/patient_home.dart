import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/assessment/question.dart';
import 'package:greycells/models/assessment/score.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/models/therapist/therapist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient_home.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientHome {
  Patient patient;

  @JsonKey(name: "behaviourLastattemtedques")
  Question behaviourLastAttemptedQuestion;

  @JsonKey(name: "personalityLastattemtedques")
  Question personalityLastAttemptedQuestion;

  List<Score> personalityScore;
  List<Score> behaviourScore;

  @JsonKey(name: "upcomingAppoinments")
  List<Appointment> upcomingAppointments;

  @JsonKey(name: "avaliableThrapist")
  List<Therapist> availableTherapists;

  @JsonKey(name: "serverTimeStamp")
  String serverTimestamp;

  PatientHome();

  factory PatientHome.fromJson(Map<String, dynamic> json) =>
      _$PatientHomeFromJson(json);

  Map<String, dynamic> toJson() => _$PatientHomeToJson(this);
}
