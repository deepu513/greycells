import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mental_health/models/registration/registration.dart';

abstract class RegistrationEvent extends Equatable {

  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationCreateUser extends RegistrationEvent {
  final bool validated;

  const RegistrationCreateUser({this.validated = false});

  @override
  List<Object> get props => [validated];

  @override
  bool get stringify => true;
}
