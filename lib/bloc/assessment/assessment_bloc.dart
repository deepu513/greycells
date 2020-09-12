import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/models/assessment/option.dart';
import 'package:greycells/models/assessment/question.dart';
import 'package:meta/meta.dart';

part 'assessment_event.dart';

part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  List<Question> questions;
  int currentQuestion;

  AssessmentBloc() : super(AssessmentInitial());

  @override
  Stream<AssessmentState> mapEventToState(
    AssessmentEvent event,
  ) async* {
    if (event is QuestionAnswered) {}

    if (event is ShowPreviousQuestion) {}

    if (event is ShowNextQuestion) {}

    if (event is SelectOption) {
      if (questions[currentQuestion].answerUpperLimit == 1) {
        questions[currentQuestion].selectedOptions.clear();
        questions[currentQuestion].selectedOptions.add(event.option);
        yield OptionSelected();
      } else if (questions[currentQuestion].answerUpperLimit > 1) {
        /// If option already present then remove it.
        var optionRemoved = false;
        questions[currentQuestion].selectedOptions.removeWhere((element) {
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
          if (questions[currentQuestion].selectedOptions.length <
              questions[currentQuestion].answerUpperLimit) {
            questions[currentQuestion].selectedOptions.add(event.option);
            yield OptionSelected();
          } else {
            yield MaxOptionsSelected();
          }
        }
      }
    }
  }
}
