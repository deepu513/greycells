import 'package:json_annotation/json_annotation.dart';

part 'assessment.g.dart';

@JsonSerializable(explicitToJson: true)
class Assessment {
  int id;

  String reportFileName;

  @JsonKey(includeIfNull: false)
  String createdDate;

  Assessment();

  factory Assessment.fromJson(Map<String, dynamic> json) =>
      _$AssessmentFromJson(json);
      
  Map<String, dynamic> toJson() => _$AssessmentToJson(this);
}
