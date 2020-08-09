import 'package:flutter/foundation.dart';
import 'package:mental_health/bloc/validation/validation_field.dart';
import 'package:mental_health/models/address/address.dart';
import 'package:mental_health/models/login/login_request.dart';
import 'package:mental_health/models/registration/registration.dart';

abstract class ValidationState {}

class ValidationStateInitial extends ValidationState {}

class ValidationLoginFieldsValid extends ValidationState {
  final LoginRequest loginRequest;

  ValidationLoginFieldsValid({this.loginRequest});
}

class ValidationRegistrationFieldsValid extends ValidationState {
  final Registration registration;

  ValidationRegistrationFieldsValid({this.registration});
}

class ValidationAddressFieldsValid extends ValidationState {
  final Address address;

  ValidationAddressFieldsValid({this.address});
}

class ValidationInvalidField extends ValidationState {
  final ValidationField field;
  final String errorMessage;

  ValidationInvalidField({@required this.field, this.errorMessage});
}
