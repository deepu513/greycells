import 'package:flutter/foundation.dart';
import 'package:greycells/models/assessment/question.dart';
import 'package:greycells/models/assessment/test_type.dart';

class Test {
  final TestType testType;
  final List<Question> questions;

  Test({@required this.testType, @required this.questions});
}
