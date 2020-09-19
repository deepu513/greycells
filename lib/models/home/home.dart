import 'package:greycells/models/assessment/question.dart';
import 'package:greycells/models/assessment/score.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable(explicitToJson: true)
class Home {
  int id;
  String email;
  String firstName;
  String lastName;
  String mobileNumber;

  //  TODO: Fix me
  String userType;

  Patient patient;

  Question behaviourLastAttemptedQuestion;
  Question personalityLastAttemptedQuestion;


  List<Score> personalityScore;
  List<Score> behaviourScore;

  Home();

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeToJson(this);
}
