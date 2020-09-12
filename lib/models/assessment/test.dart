import 'package:greycells/models/assessment/question.dart';
import 'package:greycells/models/assessment/test_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test.g.dart';

@JsonSerializable(explicitToJson: true)
class Test {
  TestType testType;
  List<Question> questions;

  @JsonKey(ignore: true)
  int currentQuestion;

  Test() {
    /// Default value
    // TODO: This can be changed with lastAttemptedQuestion from home api
    currentQuestion = 1;
  }

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);

  Map<String, dynamic> toJson() => _$TestToJson(this);
}
