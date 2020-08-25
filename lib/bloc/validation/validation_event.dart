import 'package:mental_health/models/address/address.dart';
import 'package:mental_health/models/birth_details/birth_details.dart';
import 'package:mental_health/models/login/login_request.dart';
import 'package:mental_health/models/registration/registration.dart';

abstract class ValidationEvent {}

class ValidationValidateLoginFields extends ValidationEvent {
  final LoginRequest loginRequest;

  ValidationValidateLoginFields({this.loginRequest});
}

class ValidationValidateRegistrationFields extends ValidationEvent {
  final Registration registration;

  ValidationValidateRegistrationFields({this.registration});
}

class ValidationValidateAddressFields extends ValidationEvent {
  final Address address;

  ValidationValidateAddressFields(this.address);
}

class ValidationValidateBirthDetailsFields extends ValidationEvent {
  final BirthDetails birthDetails;

  ValidationValidateBirthDetailsFields(this.birthDetails);
}
