import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/models/home/home.dart';
import 'package:greycells/repository/user_repository.dart';
import 'package:greycells/route/route_name.dart';
import 'package:meta/meta.dart';

part 'decider_event.dart';

part 'decider_state.dart';

class DeciderBloc extends Bloc<DeciderEvent, DeciderState> {
  UserRepository _userRepository;

  DeciderBloc() : super(DeciderInitial()) {
    _userRepository = UserRepository();
  }

  @override
  Stream<DeciderState> mapEventToState(
    DeciderEvent event,
  ) async* {
    if (event is DecideNextPage) {
      yield NextPageDeciding();

      try {
        Home home = await _userRepository.getHomeData();
        if (home != null) {
          if (home.patient == null) {
            yield NextPageDecided(RouteName.PATIENT_DETAIL_INPUT_PAGE);
          } else if (home.patient != null &&
              home.patient.isEligibleForTest == false) {
            yield NextPageDecided(RouteName.HOME);
          } else if (home.patient != null &&
              home.patient.isEligibleForTest == true) {
            if (home.behaviourLastAttemptedQuestion == null &&
                home.personalityLastAttemptedQuestion == null) {
              yield NextPageDecided(RouteName.ASSESSMENT_TEST_INTRO);
            } else if(home.behaviourLastAttemptedQuestion != null && home.behaviourLastAttemptedQuestion.isLastQuestion == false) {
              // Open test page and show this question number and test type
            } else if(home.personalityLastAttemptedQuestion != null && home.personalityLastAttemptedQuestion.isLastQuestion == false) {
              // Open test page and show this question number and test type
            }
          }
        } else {
          yield DeciderError();
        }
      } catch (e) {
        yield DeciderError();
      }
    }
  }
}
