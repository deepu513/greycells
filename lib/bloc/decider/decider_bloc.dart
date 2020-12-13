import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/constants/test_types.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/assessment/assessment_test_args.dart';
import 'package:greycells/models/home/patient_home.dart';
import 'package:greycells/models/home/therapist_home.dart';
import 'package:greycells/repository/settings_repository.dart';
import 'package:greycells/repository/user_repository.dart';
import 'package:greycells/route/route_name.dart';
import 'package:meta/meta.dart';

part 'decider_event.dart';

part 'decider_state.dart';

class DeciderBloc extends Bloc<DeciderEvent, DeciderState> {
  UserRepository _userRepository;
  SettingsRepository _settingsRepository;

  DeciderBloc() : super(DeciderInitial()) {
    _userRepository = UserRepository();
  }

  @override
  Stream<DeciderState> mapEventToState(DeciderEvent event) async* {
    if (event is DecideNextPage) {
      yield NextPageDeciding();
      _settingsRepository = await SettingsRepository.getInstance();
      var userType = _settingsRepository.get(SettingKey.KEY_USERTYPE);
      if (userType != null && userType == UserType.patient.index) {
        try {
          PatientHome home = await _userRepository.getPatientHomeData();
          yield _decidePatientNextPage(home);
        } catch (e) {
          yield DeciderError();
        }
      } else if (userType != null && userType == UserType.therapist.index) {
        try {
          TherapistHome therapistHome =
              await _userRepository.getTherapistHomeData();
          if (therapistHome != null) {
            therapistHome.upcomingAppointments.forEach((appointment) {
              appointment.therapist = therapistHome.therapist;
            });

            yield DecidedTherapistPage(therapistHome);
          } else {
            yield DeciderError();
          }
        } catch (e) {
          yield DeciderError();
        }
      }
    }
  }

  DeciderState _decidePatientNextPage(PatientHome home) {
    if (home != null) {
      if (home.patient == null) {
        return NextPageDecided(RouteName.INTRO_PAGE, home);
      } else if (home.patient != null &&
          home.patient.isEligibleForTest == false) {
        _settingsRepository.saveValue(
            SettingKey.KEY_PATIENT_ID, home.patient.id);
        return NextPageDecided(RouteName.PATIENT_MAIN, home);
      } else if (home.patient != null &&
          home.patient.isEligibleForTest == true) {
        _settingsRepository.saveValue(
            SettingKey.KEY_PATIENT_ID, home.patient.id);
        if (home.behaviourLastAttemptedQuestion != null &&
            home.behaviourLastAttemptedQuestion.isLastQuestion == false) {
          // Open test page and show this question number and test type
          return NextPageDecided(
            RouteName.ASSESSMENT_TEST,
            home,
            assessmentTestArguments: AssessmentTestArguments(
                testType: TestTypes.BEHAVIOUR,
                resumeFromQuestionNumber:
                    home.behaviourLastAttemptedQuestion.sequence),
          );
        } else if (home.personalityLastAttemptedQuestion != null &&
            home.personalityLastAttemptedQuestion.isLastQuestion == false) {
          // Open test page and show this question number and test type
          return NextPageDecided(
            RouteName.ASSESSMENT_TEST,
            home,
            assessmentTestArguments: AssessmentTestArguments(
                testType: TestTypes.PERSONALITY,
                resumeFromQuestionNumber:
                    home.personalityLastAttemptedQuestion.sequence),
          );
        } else if (home.behaviourLastAttemptedQuestion == null ||
            (home.behaviourLastAttemptedQuestion != null &&
                home.behaviourLastAttemptedQuestion.isLastQuestion == true)) {
          return NextPageDecided(RouteName.ASSESSMENT_TEST_INTRO, home);
        } else if (home.personalityLastAttemptedQuestion == null ||
            (home.personalityLastAttemptedQuestion != null &&
                home.personalityLastAttemptedQuestion.isLastQuestion == true)) {
          return NextPageDecided(
            RouteName.ASSESSMENT_TEST,
            home,
            assessmentTestArguments: AssessmentTestArguments(
                testType: TestTypes.PERSONALITY, resumeFromQuestionNumber: 0),
          );
        }
      }
    }
    return DeciderError();
  }
}
