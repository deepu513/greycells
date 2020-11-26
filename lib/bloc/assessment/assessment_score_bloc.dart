import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:greycells/models/assessment/assessment_response.dart';
import 'package:greycells/repository/assessment_test_repository.dart';

part 'assessment_score_event.dart';
part 'assessment_score_state.dart';

class AssessmentScoreBloc
    extends Bloc<AssessmentScoreEvent, AssessmentScoreState> {
  AssessmentTestRepository _testRepository;

  AssessmentScoreBloc() : super(AssessmentScoreInitial()) {
    _testRepository = AssessmentTestRepository();
  }

  @override
  Stream<AssessmentScoreState> mapEventToState(
    AssessmentScoreEvent event,
  ) async* {
    if (event is LoadAssessmentScores) {
      yield AssessmentScoreLoading();
      try {
        List<AssessmentResponse> response =
            await _testRepository.getAssessmentScores(event.patientId);

        if (response != null) {
          if (response.isEmpty)
            yield AssessmentScoreEmpty();
          else {
            yield AssessmentScoreLoaded(response);
          }
        } else
          yield AssessmentScoreError();
      } catch (e) {
        debugPrint(e);
        yield AssessmentScoreError();
      }
    }
  }
}
