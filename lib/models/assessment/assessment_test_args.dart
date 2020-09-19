import 'package:flutter/foundation.dart';
import 'package:greycells/constants/test_types.dart';

class AssessmentTestArguments {
  final TestTypes testType;
  final int resumeFromQuestionNumber;

  AssessmentTestArguments(
      {@required this.testType, @required this.resumeFromQuestionNumber})
      : assert(testType != null),
        assert(resumeFromQuestionNumber != null);
}
