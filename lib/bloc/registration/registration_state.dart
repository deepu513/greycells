import 'package:flutter/foundation.dart';

abstract class RegistrationState {
  const RegistrationState();
}

class RegistrationStateInitial extends RegistrationState {}

class RegistrationInProgress extends RegistrationState {}

class RegistrationSuccessful extends RegistrationState {}

class RegistrationUnsuccessful extends RegistrationState {
  final String error;

  const RegistrationUnsuccessful({@required this.error});
}

class PasswordVisibilityToggled extends RegistrationState {}

class ConfirmPasswordVisibilityToggled extends RegistrationState {}