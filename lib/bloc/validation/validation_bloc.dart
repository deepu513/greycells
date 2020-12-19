import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/models/task/task_item.dart';
import 'package:intl/intl.dart';
import 'package:greycells/bloc/validation/validation_field.dart';
import 'package:greycells/bloc/validation/validation_state.dart';
import 'package:greycells/constants/relationship.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/models/login/login_request.dart';
import 'package:greycells/models/registration/registration.dart';

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
      var validationField = _validateAddressFields(event.patient);

      if (validationField == ValidationField.NONE) {
        yield AddressFieldsValid(address: event.patient.address);
      } else
        yield ValidationInvalidField(field: validationField);
    } else if (event is ValidateBirthDetailsFields) {
      var validationField = _validateBirthDetails(event.patient);

      if (validationField == ValidationField.NONE) {
        yield BirthDetailsValid(event.patient);
      } else
        yield ValidationInvalidField(field: validationField);
    } else if (event is ValidateGuardianDetailsFields) {
      var validationField = _validateGuardianDetails(event.patient);

      if (validationField == ValidationField.NONE) {
        yield GuardianDetailsValid(event.patient);
      } else
        yield ValidationInvalidField(field: validationField);
    } else if (event is ValidateTaskItemFields) {
      var validationField = _validateTaskItemField(event.taskItem);

      if (validationField == ValidationField.NONE) {
        yield TaskItemValid(event.taskItem);
      } else
        yield ValidationInvalidField(field: validationField);
    }

    if (event is ValidatePersonalDetailsField) {
      if (event.patient.user.mobileNumber.isNullOrEmpty() ||
          !event.patient.user.mobileNumber.hasRequiredLength(10))
        yield ValidationInvalidField(field: ValidationField.CONTACT_NUMBER);
      else
        yield PersonalDetailsValid(event.patient);
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
    if (!registration.password.hasRequiredLength(6))
      return ValidationField.LENGTH;
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

  ValidationField _validateAddressFields(Patient patient) {
    if (patient.address.houseNumber.isNullOrEmpty())
      return ValidationField.HOUSE_NUMBER;
    if (patient.address.roadName.isNullOrEmpty())
      return ValidationField.ROAD_NAME;
    if (patient.address.city.isNullOrEmpty()) return ValidationField.CITY;
    if (patient.address.state.isNullOrEmpty()) return ValidationField.STATE;
    if (patient.address.country.isNullOrEmpty()) return ValidationField.COUNTRY;
    if (patient.address.pincode.isNullOrEmpty()) return ValidationField.PINCODE;
    if (patient.isMinor) {
      if (patient.guardian.address.houseNumber.isNullOrEmpty())
        return ValidationField.GUARDIAN_HOUSE_NUMBER;
      if (patient.guardian.address.roadName.isNullOrEmpty())
        return ValidationField.GUARDIAN_ROAD_NAME;
      if (patient.guardian.address.city.isNullOrEmpty())
        return ValidationField.GUARDIAN_CITY;
      if (patient.guardian.address.state.isNullOrEmpty())
        return ValidationField.GUARDIAN_STATE;
      if (patient.guardian.address.country.isNullOrEmpty())
        return ValidationField.GUARDIAN_COUNTRY;
      if (patient.guardian.address.pincode.isNullOrEmpty())
        return ValidationField.GUARDIAN_PINCODE;
    }
    return ValidationField.NONE;
  }

  ValidationField _validateBirthDetails(Patient patient) {
    if (patient.placeOfBirth.isNullOrEmpty()) return ValidationField.PLACE_PART;
    if (!_validDateTime(patient.dayPart, patient.monthPart, patient.yearPart))
      return ValidationField.DATE_PART;
    if (!_validDateTime(patient.dayPart, patient.monthPart, patient.yearPart,
        patient.hourPart, patient.minutePart)) return ValidationField.TIME_PART;
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

  ValidationField _validateGuardianDetails(Patient patient) {
    if (patient.guardian.relationShip == Relationship.other &&
        patient.guardian.readableRelationship.isNullOrEmpty()) {
      return ValidationField.OTHER_RELATION;
    }
    if (patient.guardian.firstName.isNullOrEmpty())
      return ValidationField.GUARDIAN_FIRST_NAME;
    if (patient.guardian.lastName.isNullOrEmpty())
      return ValidationField.GUARDIAN_LAST_NAME;
    if (patient.guardian.mobileNumber.isNullOrEmpty())
      return ValidationField.CONTACT_NUMBER;
    return ValidationField.NONE;
  }

  ValidationField _validateTaskItemField(TaskItem taskItem) {
    if (taskItem.title.isNullOrEmpty()) return ValidationField.TASK_ITEM_TITLE;
    if (taskItem.description.isNullOrEmpty())
      return ValidationField.TASK_ITEM_DESC;
    return ValidationField.NONE;
  }
}
