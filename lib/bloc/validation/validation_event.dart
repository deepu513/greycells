import 'package:greycells/models/login/login_request.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/models/registration/registration.dart';

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
  final Patient patient;

  ValidateAddressFields(this.patient);
}

class ValidateBirthDetailsFields extends ValidationEvent {
  final Patient patient;

  ValidateBirthDetailsFields(this.patient);
}

class ValidateGuardianDetailsFields extends ValidationEvent {
  final Patient patient;

  ValidateGuardianDetailsFields(this.patient);
}
