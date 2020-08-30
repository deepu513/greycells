import 'package:mental_health/models/address/address.dart';
import 'package:mental_health/models/birth_details/birth_details.dart';
import 'package:mental_health/models/guardian_details/guardian_details.dart';
import 'package:mental_health/models/login/login_request.dart';
import 'package:mental_health/models/registration/registration.dart';

abstract class ValidationEvent {}

class ValidateLoginFields extends ValidationEvent {
  final LoginRequest loginRequest;

  ValidateLoginFields({this.loginRequest});
}

class ValidateRegistrationFields extends ValidationEvent {
  final Registration registration;

  ValidateRegistrationFields({this.registration});
}

class ValidateAddressFields extends ValidationEvent {
  final Address address;

  ValidateAddressFields(this.address);
}

class ValidateBirthDetailsFields extends ValidationEvent {
  final BirthDetails birthDetails;

  ValidateBirthDetailsFields(this.birthDetails);
}

class ValidateGuardianDetailsFields extends ValidationEvent {
  final GuardianDetails guardianDetails;

  ValidateGuardianDetailsFields(this.guardianDetails);
}
