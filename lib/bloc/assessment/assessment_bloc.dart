import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/models/assessment/option.dart';
import 'package:greycells/models/assessment/question.dart';
import 'package:greycells/models/assessment/test.dart';
import 'package:greycells/repository/assessment_test_repository.dart';
import 'package:meta/meta.dart';

part 'assessment_event.dart';

part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  int _currentQuestionNumber;
  Test _test;

  AssessmentTestRepository _testRepository;

  AssessmentBloc() : super(AssessmentInitial()) {
    _testRepository = AssessmentTestRepository();
    _currentQuestionNumber = 1;
  }

  @override
  Stream<AssessmentState> mapEventToState(
    AssessmentEvent event,
  ) async* {
    if (event is LoadAssessmentTest) {
      yield AssessmentTestLoading();
      try {
        Test receivedTest = await _testRepository.getTest();
        if (receivedTest != null) {
          this._test = receivedTest;
          // TODO: You can modify currentQuestion here and set it according to home api response.
          yield ShowQuestion(
              _test.questions[_currentQuestionNumber], _test.questions.length);
        } else
          yield AssessmentError();
      } catch (e) {
        print(e);
        yield AssessmentError();
      }
    }

    if (event is QuestionAnswered) {
      // TODO: Hit api and move to next question here
    }

    if (event is ShowPreviousQuestion) {
      --_currentQuestionNumber;

      yield ShowQuestion(
          _test.questions[_currentQuestionNumber], _test.questions.length);
    }

    if (event is SelectOption) {
      var currentQuestion = _test.questions[_currentQuestionNumber];
      if (currentQuestion.answerUpperLimit == 1) {
        currentQuestion.selectedOptions.clear();
        currentQuestion.selectedOptions.add(event.option);
        yield OptionSelected();
      } else if (currentQuestion.answerUpperLimit > 1) {
        /// If option already present then remove it.
        var optionRemoved = false;
        currentQuestion.selectedOptions.removeWhere((element) {
          if (element.id == event.option.id) {
            optionRemoved = true;
            return true;
          } else
            return false;
        });

        if (optionRemoved) {
          yield OptionDeselected();
        } else {
          /// Option not present, add it.
          if (currentQuestion.selectedOptions.length <
              currentQuestion.answerUpperLimit) {
            currentQuestion.selectedOptions.add(event.option);
            yield OptionSelected();
          } else {
            yield MaxOptionsSelected();
          }
        }
      }
    }
  }
}
