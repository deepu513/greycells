import 'package:equatable/equatable.dart';
import 'package:mental_health/models/login/login_request.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoginInitiated extends AuthenticationEvent {
  final LoginRequest loginRequest;
  final bool valid;

  const LoginInitiated({@required this.loginRequest, this.valid = false});

  @override
  List<Object> get props => [loginRequest];

  @override
  bool get stringify => true;
}

class LoggedOut extends AuthenticationEvent {}