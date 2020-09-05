import 'package:meta/meta.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

/// This state indicates that the app is waiting to see if user is authenticated
/// or not, when in this state, we can show user a splash screen .
class AuthenticationInitial extends AuthenticationState {}

/// This state indicates that the app is either saving or deleting the
/// authentication token, when in this state, we can show user a loading indicator.
class AuthenticationLoading extends AuthenticationState {}

/// This state indicates that user is successfully authenticated,
/// when in this state, we can show user home screen.
class AuthenticationAuthenticated extends AuthenticationState {}

/// This state indicates that user is not authenticated,
/// when in this state, we can show user login screen.
class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String error;

  const AuthenticationFailure({@required this.error});
}

class PasswordVisibilityToggled extends AuthenticationState {}
