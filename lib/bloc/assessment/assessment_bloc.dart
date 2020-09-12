import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'assessment_event.dart';

part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  AssessmentBloc() : super(AssessmentInitial());

  @override
  Stream<AssessmentState> mapEventToState(
    AssessmentEvent event,
  ) async* {

  }
}
