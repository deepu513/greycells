part of 'eligibility_check_bloc.dart';

abstract class EligibilityCheckEvent {
  const EligibilityCheckEvent();
}

class CheckFollowupEligibility extends EligibilityCheckEvent {
  final int therapistId;
  final int meetingTypeId;

  CheckFollowupEligibility(this.therapistId, this.meetingTypeId);
}
