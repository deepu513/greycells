import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoginInitiated extends AuthenticationEvent {
  final String contactNumber;
  final bool valid;

  const LoginInitiated({@required this.contactNumber, this.valid = false});

  @override
  List<Object> get props => [contactNumber];

  @override
  bool get stringify => true;
}

class LoggedOut extends AuthenticationEvent {}