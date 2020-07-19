import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mental_health/models/user/user.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

/// This state indicates that the app is waiting to see if user is authenticated
/// or not, when in this state, we can show user a splash screen .
class AuthenticationInitial extends AuthenticationState {}

/// This state indicates that the app is either saving or deleting the
/// authentication token, when in this state, we can show user a loading indicator.
class AuthenticationLoading extends AuthenticationState {}

/// This state indicates that user is successfully authenticated,
/// when in this state, we can show user home screen.
class AuthenticationAuthenticated extends AuthenticationState {
  final User user;

  AuthenticationAuthenticated(this.user);

  @override
  List<Object> get props => [user];

  @override
  bool get stringify => true;
}

/// This state indicates that user is not authenticated,
/// when in this state, we can show user login screen.
class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationUserNotFound extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String error;

  const AuthenticationFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  bool get stringify => true;
}
