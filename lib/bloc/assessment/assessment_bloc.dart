import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/models/assessment/option.dart';
import 'package:greycells/models/assessment/question.dart';
import 'package:greycells/models/assessment/save_option_request.dart';
import 'package:greycells/models/assessment/test.dart';
import 'package:greycells/repository/assessment_test_repository.dart';
import 'package:greycells/repository/settings_repository.dart';
import 'package:meta/meta.dart';

part 'assessment_event.dart';

part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  int _currentQuestionNumber;
  int _resumedQuestionNumber;
  Test _test;

  AssessmentTestRepository _testRepository;
  SettingsRepository _settingsRepository;

  AssessmentBloc() : super(AssessmentInitial()) {
    _testRepository = AssessmentTestRepository();
    _currentQuestionNumber = 0;
    SettingsRepository.getInstance()
        .then((value) => _settingsRepository = value);
  }

  @override
  Stream<AssessmentState> mapEventToState(
    AssessmentEvent event,
  ) async* {
    if (event is UpdateCurrentQuestionNumber) {
      _currentQuestionNumber = event.currentQuestionNumber;
      _resumedQuestionNumber = _currentQuestionNumber;
      yield CurrentQuestionNumberUpdated();
    }

    if (event is LoadAssessmentTest) {
      yield AssessmentTestLoading();
      try {
        Test receivedTest = await _testRepository.getTest(event.testTypeId);
        if (receivedTest != null) {
          /// You can modify currentQuestion here and set it according to
          /// home api response or from shared prefs
          this._test = receivedTest;

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
      if (_test.questions[_currentQuestionNumber].answered == true) {
        ++_currentQuestionNumber;
        if (_currentQuestionNumber < _test.questions.length) {
          yield ShowQuestion(
              _test.questions[_currentQuestionNumber], _test.questions.length);
        } else {
          _currentQuestionNumber = 0;
          yield TestComplete(_test.testType.id);
        }
      } else {
        try {
          yield SavingSelectedOption(
              _test.questions[_currentQuestionNumber], _test.questions.length);

          final currentQuestion = _test.questions[_currentQuestionNumber];
          final int patientId =
              await _settingsRepository.get(SettingKey.KEY_PATIENT_ID);

          SaveOptionRequest optionRequest = SaveOptionRequest()
            ..patientId = patientId
            ..questionId = currentQuestion.id
            ..score = currentQuestion.selectedOptions[0].score
            ..testTypeId = _test.testType.id
            ..selectedOptionIds =
                currentQuestion.selectedOptions.map((e) => e.id).toList();

          bool optionSaveResult = await _testRepository.saveOption(
              saveOptionRequest: optionRequest);
          if (optionSaveResult == true) {
            _test.questions[_currentQuestionNumber].answered = true;
            ++_currentQuestionNumber;
            if (_currentQuestionNumber < _test.questions.length) {
              yield ShowQuestion(_test.questions[_currentQuestionNumber],
                  _test.questions.length);
            } else {
              _currentQuestionNumber = 0;
              yield TestComplete(_test.testType.id);
            }
          } else {
            yield ErrorWhileSavingSelectedOption(
                _test.questions[_currentQuestionNumber],
                _test.questions.length);
          }
        } catch (e) {
          print(e);
          yield ErrorWhileSavingSelectedOption(
              _test.questions[_currentQuestionNumber], _test.questions.length);
        }
      }
    }

    if (event is ShowPreviousQuestion) {
      if (_currentQuestionNumber >= 1 &&
          _currentQuestionNumber > _resumedQuestionNumber) {
        --_currentQuestionNumber;

        yield ShowQuestion(
            _test.questions[_currentQuestionNumber], _test.questions.length);
      } else
        yield NoMoreQuestions();
    }

    if (event is TrySelectingOption) {
      var currentQuestion = _test.questions[_currentQuestionNumber];
      if (currentQuestion.answered) {
        yield AlreadyAnswered();
      } else if (currentQuestion.answerUpperLimit == 1) {
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
