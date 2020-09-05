import 'package:equatable/equatable.dart';

abstract class RegistrationEvent {
  const RegistrationEvent();
}

class RegistrationCreateUser extends RegistrationEvent {
  final bool validated;

  const RegistrationCreateUser({this.validated = false});
}

class TogglePasswordVisibility extends RegistrationEvent {}
class ToggleConfirmPasswordVisibility extends RegistrationEvent {}