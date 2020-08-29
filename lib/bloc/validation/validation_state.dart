import 'package:flutter/foundation.dart';
import 'package:mental_health/bloc/validation/validation_field.dart';
import 'package:mental_health/models/address/address.dart';
import 'package:mental_health/models/birth_details/birth_details.dart';
import 'package:mental_health/models/guardian_details/guardian_details.dart';
import 'package:mental_health/models/login/login_request.dart';
import 'package:mental_health/models/registration/registration.dart';

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
  final BirthDetails birthDetails;

  BirthDetailsValid(this.birthDetails);
}

class GuardianDetailsValid extends ValidationState {
  final GuardianDetails guardianDetails;

  GuardianDetailsValid(this.guardianDetails);
}

class ValidationInvalidField extends ValidationState {
  final ValidationField field;

  ValidationInvalidField({@required this.field});
}
