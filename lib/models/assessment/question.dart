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

  @JsonKey(name: "optionMaster")
  List<Option> options;

  @JsonKey(ignore: true)
  List<Option> selectedOptions;

  @JsonKey(ignore: true)
  bool answered;

  Question() {
    selectedOptions = List();
    answered = false;
  }

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
