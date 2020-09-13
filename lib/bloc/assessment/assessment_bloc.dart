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
    _currentQuestionNumber = 0;
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
      _test.questions[_currentQuestionNumber].answered = true;
      ++_currentQuestionNumber;

      yield ShowQuestion(
          _test.questions[_currentQuestionNumber], _test.questions.length);
    }

    if (event is ShowPreviousQuestion) {
      if (_currentQuestionNumber >= 1) {
        --_currentQuestionNumber;

        yield ShowQuestion(
            _test.questions[_currentQuestionNumber], _test.questions.length);
      } else
        yield NoMoreQuestions();
    }

    if (event is TrySelectingOption) {
      var currentQuestion = _test.questions[_currentQuestionNumber];
      if(currentQuestion.answered) {
        yield AlreadyAnswered();
      }
      else if (currentQuestion.answerUpperLimit == 1) {

        /// Make all elements as not selected
        currentQuestion.options.forEach((element) {
          element.selected = false;
        });

        /// Clear selected options list
        currentQuestion.selectedOptions.clear();

        /// Make current option selected
        event.option.selected = true;

        /// Add current option to selected option list
        currentQuestion.selectedOptions.add(event.option);
        yield OptionSelected(currentQuestion, _test.questions.length);
      } else if (currentQuestion.answerUpperLimit > 1) {
        var optionRemoved = false;

        /// If option already present then remove it.
        currentQuestion.selectedOptions.removeWhere((element) {
          if (element.id == event.option.id) {
            optionRemoved = true;
            return true;
          } else
            return false;
        });

        if (optionRemoved) {
          event.option.selected = false;
          yield OptionDeselected(currentQuestion, _test.questions.length);
        } else {
          /// Option not present, add it.
          if (currentQuestion.selectedOptions.length <
              currentQuestion.answerUpperLimit) {
            currentQuestion.selectedOptions.add(event.option);
            event.option.selected = true;
            yield OptionSelected(currentQuestion, _test.questions.length);
          } else {
            yield MaxOptionsSelected();
          }
        }
      }
    }
  }
}
