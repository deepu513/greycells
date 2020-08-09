import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mental_health/bloc/validation/validation_field.dart';
import 'package:mental_health/bloc/validation/validation_state.dart';
import 'package:mental_health/models/address/address.dart';
import 'package:mental_health/models/login/login_request.dart';
import 'package:mental_health/models/registration/registration.dart';
import 'package:mental_health/utils.dart';

import './bloc.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  @override
  ValidationState get initialState => ValidationStateInitial();

  @override
  Stream<ValidationState> mapEventToState(
    ValidationEvent event,
  ) async* {
    if (event is ValidationValidateLoginFields) {
      var validationField = _validateLoginFields(event.loginRequest);

      if (validationField == ValidationField.NONE) {
        yield ValidationLoginFieldsValid(loginRequest: event.loginRequest);
      } else
        yield ValidationInvalidField(field: validationField);
    } else if (event is ValidationValidateRegistrationFields) {
      var validationField = _validateRegistrationFields(event.registration);

      if (validationField == ValidationField.NONE) {
        yield ValidationRegistrationFieldsValid(
            registration: event.registration);
      } else
        yield ValidationInvalidField(field: validationField);
    } else if (event is ValidationValidateAddressFields) {
      var validationField = _validateAddressFields(event.address);

      if (validationField == ValidationField.NONE) {
        yield ValidationAddressFieldsValid(address: event.address);
      } else
        yield ValidationInvalidField(field: validationField);
    }
  }

  ValidationField _validateRegistrationFields(Registration registration) {
    if (Utils.isNullOrEmpty(registration.firstName))
      return ValidationField.FIRST_NAME;
    if (Utils.isNullOrEmpty(registration.lastName))
      return ValidationField.LAST_NAME;
    if (Utils.isNullOrEmpty(registration.email)) return ValidationField.EMAIL;
    if (Utils.isNullOrEmpty(registration.mobileNumber))
      return ValidationField.CONTACT_NUMBER;
    if (Utils.isNullOrEmpty(registration.password))
      return ValidationField.PASSWORD;
    if (Utils.isNullOrEmpty(registration.confirmPassword))
      return ValidationField.CONFIRM_PASSWORD;
    if (registration.password != registration.confirmPassword)
      return ValidationField.CONFIRM_PASSWORD;
    return ValidationField.NONE;
  }

  ValidationField _validateLoginFields(LoginRequest request) {
    if (Utils.isNullOrEmpty(request.email))
      return ValidationField.EMAIL;
    else if (Utils.isNullOrEmpty(request.password))
      return ValidationField.PASSWORD;
    return ValidationField.NONE;
  }

  ValidationField _validateAddressFields(Address address) {
    if (Utils.isNullOrEmpty(address.houseNumber))
      return ValidationField.HOUSE_NUMBER;
    if (Utils.isNullOrEmpty(address.roadName)) return ValidationField.ROAD_NAME;
    if (Utils.isNullOrEmpty(address.city)) return ValidationField.CITY;
    if (Utils.isNullOrEmpty(address.state)) return ValidationField.STATE;
    if (Utils.isNullOrEmpty(address.country)) return ValidationField.COUNTRY;
    if (Utils.isNullOrEmpty(address.pincode)) return ValidationField.PINCODE;
    return ValidationField.NONE;
  }
}
