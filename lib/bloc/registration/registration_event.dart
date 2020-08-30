import 'package:equatable/equatable.dart';

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
