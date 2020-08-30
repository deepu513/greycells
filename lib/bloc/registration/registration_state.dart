import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationStateInitial extends RegistrationState {}

class RegistrationInProgress extends RegistrationState {}

class RegistrationSuccessful extends RegistrationState {
//  final User user;

  const RegistrationSuccessful(/*{@required this.user}*/);

  @override
  List<Object> get props => [
        /*user*/
      ];

  @override
  bool get stringify => true;
}

class RegistrationUnsuccessful extends RegistrationState {
  final String error;

  const RegistrationUnsuccessful({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  bool get stringify => true;
}
