import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoginInitiated extends AuthenticationEvent {
  final bool valid;

  const LoginInitiated({this.valid = false});

  @override
  List<Object> get props => [valid];

  @override
  bool get stringify => true;
}

class LoggedOut extends AuthenticationEvent {}
