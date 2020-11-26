import 'package:greycells/models/assessment/assessment.dart';
import 'package:greycells/models/assessment/score.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assessment_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AssessmentResponse {
  Assessment assessment;

  @JsonKey(name: "beh_score")
  List<Score> behaviourScore;

  @JsonKey(name: "per_score")
  List<Score> personalityScore;

  @JsonKey(name: "allPer_score")
  List<Score> allPersonalityScore;

  AssessmentResponse();

  factory AssessmentResponse.fromJson(Map<String, dynamic> json) =>
      _$AssessmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentResponseToJson(this);
}
