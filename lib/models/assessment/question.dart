import 'package:greycells/models/assessment/option.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  int id;
  int sequence;
  int answerUpperLimit;

  bool isActive;
  bool isLastQuestion;

  @JsonKey(name: "name")
  String questionText;

  List<Option> options;

  @JsonKey(ignore: true)
  List<Option> selectedOptions;

  Question() {
    selectedOptions = List();
  }

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
