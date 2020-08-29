import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:mental_health/bloc/validation/validation_field.dart';
import 'package:mental_health/bloc/validation/validation_state.dart';
import 'package:mental_health/constants/relationship.dart';
import 'package:mental_health/extensions.dart';
import 'package:mental_health/models/address/address.dart';
import 'package:mental_health/models/birth_details/birth_details.dart';
import 'package:mental_health/models/guardian_details/guardian_details.dart';
import 'package:mental_health/models/login/login_request.dart';
import 'package:mental_health/models/registration/registration.dart';

import './bloc.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  ValidationBloc() : super(ValidationStateInitial());

  @override
  Stream<ValidationState> mapEventToState(
    ValidationEvent event,
  ) async* {
    if (event is ValidateLoginFields) {
      var validationField = _validateLoginFields(event.loginRequest);

      if (validationField == ValidationField.NONE) {
        yield LoginFieldsValid(loginRequest: event.loginRequest);
      } else
        yield ValidationInvalidField(field: validationField);
    } else if (event is ValidateRegistrationFields) {
      var validationField = _validateRegistrationFields(event.registration);

      if (validationField == ValidationField.NONE) {
        yield RegistrationFieldsValid(registration: event.registration);
      } else
        yield ValidationInvalidField(field: validationField);
    } else if (event is ValidateAddressFields) {
      var validationField = _validateAddressFields(event.address);

      if (validationField == ValidationField.NONE) {
        yield AddressFieldsValid(address: event.address);
      } else
        yield ValidationInvalidField(field: validationField);
    } else if (event is ValidateBirthDetailsFields) {
      var validationField = _validateBirthDetails(event.birthDetails);

      if (validationField == ValidationField.NONE) {
        yield BirthDetailsValid(event.birthDetails);
      } else
        yield ValidationInvalidField(field: validationField);
    } else if (event is ValidateGuardianDetailsFields) {
      var validationField = _validateGuardianDetails(event.guardianDetails);

      if (validationField == ValidationField.NONE) {
        yield GuardianDetailsValid(event.guardianDetails);
      } else
        yield ValidationInvalidField(field: validationField);
    }
  }

  ValidationField _validateRegistrationFields(Registration registration) {
    if (registration.firstName.isNullOrEmpty())
      return ValidationField.FIRST_NAME;
    if (registration.lastName.isNullOrEmpty()) return ValidationField.LAST_NAME;
    if (registration.mobileNumber.isNullOrEmpty())
      return ValidationField.CONTACT_NUMBER;
    if (registration.email.isNullOrEmpty()) return ValidationField.EMAIL;
    if (registration.password.isNullOrEmpty()) return ValidationField.PASSWORD;
    if (registration.confirmPassword.isNullOrEmpty() ||
        registration.password != registration.confirmPassword)
      return ValidationField.CONFIRM_PASSWORD;
    return ValidationField.NONE;
  }

  ValidationField _validateLoginFields(LoginRequest request) {
    if (request.email.isNullOrEmpty())
      return ValidationField.EMAIL;
    else if (request.password.isNullOrEmpty()) return ValidationField.PASSWORD;
    return ValidationField.NONE;
  }

  ValidationField _validateAddressFields(Address address) {
    if (address.houseNumber.isNullOrEmpty())
      return ValidationField.HOUSE_NUMBER;
    if (address.roadName.isNullOrEmpty()) return ValidationField.ROAD_NAME;
    if (address.city.isNullOrEmpty()) return ValidationField.CITY;
    if (address.state.isNullOrEmpty()) return ValidationField.STATE;
    if (address.country.isNullOrEmpty()) return ValidationField.COUNTRY;
    if (address.pincode.isNullOrEmpty()) return ValidationField.PINCODE;
    return ValidationField.NONE;
  }

  ValidationField _validateBirthDetails(BirthDetails birthDetails) {
    if (birthDetails.placeOfBirth.isNullOrEmpty())
      return ValidationField.PLACE_PART;
    if (!_validDateTime(
        birthDetails.dayPart, birthDetails.monthPart, birthDetails.yearPart))
      return ValidationField.DATE_PART;
    if (!_validDateTime(
        birthDetails.dayPart,
        birthDetails.monthPart,
        birthDetails.yearPart,
        birthDetails.hourPart,
        birthDetails.minutePart)) return ValidationField.TIME_PART;
    return ValidationField.NONE;
  }

  bool _validDateTime(String dayPart, String monthPart, String yearPart,
      [String hourPart = "00", String minutePart = "00"]) {
    try {
      DateFormat dateFormat = DateFormat("dd/MM/yyyy hh:mm");
      dateFormat
          .parseStrict('$dayPart/$monthPart/$yearPart $hourPart:$minutePart');
      return true;
    } catch (e) {
      return false;
    }
  }

  ValidationField _validateGuardianDetails(GuardianDetails guardianDetails) {
    if (guardianDetails.relationShip == Relationship.other &&
        guardianDetails.readableRelationship.isNullOrEmpty()) {
      return ValidationField.OTHER_RELATION;
    }
    if (guardianDetails.mobileNumber.isNullOrEmpty())
      return ValidationField.CONTACT_NUMBER;
    return ValidationField.NONE;
  }
}
