import 'package:flutter/foundation.dart';
import 'package:greycells/bloc/validation/validation_field.dart';
import 'package:greycells/models/address/address.dart';
import 'package:greycells/models/login/login_request.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/models/registration/registration.dart';

abstract class ValidationState {}

class ValidationStateInitial extends ValidationState {}

class LoginFieldsValid extends ValidationState {
  final LoginRequest loginRequest;

  LoginFieldsValid({this.loginRequest});
}

class RegistrationFieldsValid extends ValidationState {
  final Registration registration;

  RegistrationFieldsValid({this.registration});
}

class AddressFieldsValid extends ValidationState {
  final Address address;

  AddressFieldsValid({this.address});
}

class BirthDetailsValid extends ValidationState {
  final Patient patient;

  BirthDetailsValid(this.patient);
}

class GuardianDetailsValid extends ValidationState {
  final Patient patient;

  GuardianDetailsValid(this.patient);
}

class ValidationInvalidField extends ValidationState {
  final ValidationField field;

  ValidationInvalidField({@required this.field});
}
