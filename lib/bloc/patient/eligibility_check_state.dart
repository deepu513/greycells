part of 'eligibility_check_bloc.dart';

abstract class EligibilityCheckState {
  const EligibilityCheckState();
}

class EligibilityCheckInitial extends EligibilityCheckState {}

class EligibilityChecking extends EligibilityCheckState {}

class FollowupEligiblie extends EligibilityCheckState {}

class FollowupNotEligible extends EligibilityCheckState {}
