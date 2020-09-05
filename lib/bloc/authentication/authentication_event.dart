abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {}

class LoginInitiated extends AuthenticationEvent {
  final bool valid;

  const LoginInitiated({this.valid = false});
}

class LoggedOut extends AuthenticationEvent {}

class TogglePasswordVisibility extends AuthenticationEvent {}
