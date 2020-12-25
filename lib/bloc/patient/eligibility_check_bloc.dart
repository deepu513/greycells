import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greycells/repository/user_repository.dart';

part 'eligibility_check_event.dart';
part 'eligibility_check_state.dart';

class EligibilityCheckBloc
    extends Bloc<EligibilityCheckEvent, EligibilityCheckState> {
  UserRepository _userRepository;

  EligibilityCheckBloc() : super(EligibilityCheckInitial()) {
    _userRepository = UserRepository();
  }

  @override
  Stream<EligibilityCheckState> mapEventToState(
    EligibilityCheckEvent event,
  ) async* {
    if (event is CheckFollowupEligibility) {
      yield EligibilityChecking();
      try {
        var isEligible = await _userRepository.isEligibleForFollowup(
            therapistId: event.therapistId, meetingTypeId: event.meetingTypeId);

        if (isEligible)
          yield FollowupEligiblie();
        else
          yield FollowupNotEligible();
      } catch (e) {
        yield FollowupNotEligible();
      }
    }
  }
}
