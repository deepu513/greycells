import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mental_health/models/user/user.dart';

abstract class RegistrationEvent extends Equatable {

  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationCreateUser extends RegistrationEvent {
  final User user;
  final bool validated;

  const RegistrationCreateUser({@required this.user, this.validated = false});

  @override
  List<Object> get props => [user, validated];

  @override
  bool get stringify => true;
}
