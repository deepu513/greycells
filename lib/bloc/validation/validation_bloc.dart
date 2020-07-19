import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mental_health/bloc/validation/validation_state.dart';
import 'package:mental_health/models/user/user.dart';
import 'package:mental_health/utils.dart';

import './bloc.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  @override
  ValidationState get initialState => ValidationStateInitial();

  @override
  Stream<ValidationState> mapEventToState(
    ValidationEvent event,
  ) async* {
    if (event is ValidationValidateUser) {
      var validationField = _validateUserFields(event.user);

      if (validationField == ValidationField.NONE) {
        yield ValidationUserValid(user: event.user);
      } else
        yield ValidationFailed(field: validationField);
    } else if (event is ValidationValidateContactNumber) {
      if (Utils.hasRequiredLength(event.contactNumber, 10)) {
        yield ValidationContactNumberValid(contactNumber: event.contactNumber);
      } else
        yield ValidationFailed(field: ValidationField.CONTACT_NUMBER);
    }
  }

  ValidationField _validateUserFields(User user) {
    if (Utils.isNullOrEmpty(user.name))
      return ValidationField.NAME;
    else if (!Utils.hasRequiredLength(user.contactNumber, 10))
      return ValidationField.CONTACT_NUMBER;
    else if (user.city == null)
      return ValidationField.CITY;
    else
      return ValidationField.NONE;
  }
}
