import 'package:flutter/foundation.dart';
import 'package:greycells/models/assessment/question.dart';
import 'package:greycells/models/assessment/test_type.dart';
import 'package:json_annotation/json_annotation.dart';

class Test {
  final TestType testType;
  final List<Question> questions;

  @JsonKey(ignore: true)
  int currentQuestion;

  Test({@required this.testType, @required this.questions})
      : assert(testType != null),
        assert(questions != null) {
    /// Default value
    currentQuestion = 1;
  }
}
