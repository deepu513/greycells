import 'package:json_annotation/json_annotation.dart';

part 'save_option_request.g.dart';

@JsonSerializable(explicitToJson: true)
class SaveOptionRequest {
  @JsonKey(name: "TestTypeId")
  int testTypeId;

  @JsonKey(name: "QuestionId")
  int questionId;

  @JsonKey(name: "OptionMasterIds")
  List<int> selectedOptionIds;

  @JsonKey(name: "Score")
  int score;

  @JsonKey(name: "PatientId")
  int patientId;

  @JsonKey(name: "Title")
  String testTitle;

  SaveOptionRequest();

  factory SaveOptionRequest.fromJson(Map<String, dynamic> json) =>
      _$SaveOptionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SaveOptionRequestToJson(this);
}
