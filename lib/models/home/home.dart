import 'package:greycells/models/assessment/question.dart';
import 'package:greycells/models/assessment/score.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable(explicitToJson: true)
class Home {
  Patient patient;

  @JsonKey(name: "behaviourLastattemtedques")
  Question behaviourLastAttemptedQuestion;

  @JsonKey(name: "personalityLastattemtedques")
  Question personalityLastAttemptedQuestion;

  List<Score> personalityScore;
  List<Score> behaviourScore;

  @JsonKey(name: "serverTimeStamp")
  String serverTimestamp;

  Home();

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeToJson(this);
}
