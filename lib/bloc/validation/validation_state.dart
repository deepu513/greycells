import 'package:flutter/foundation.dart';
import 'package:mental_health/models/user/user.dart';

abstract class ValidationState {}

class ValidationStateInitial extends ValidationState {}

class ValidationUserValid extends ValidationState {
  final User user;

  ValidationUserValid({this.user});
}

class ValidationContactNumberValid extends ValidationState {
  final String contactNumber;

  ValidationContactNumberValid({this.contactNumber});
}

class ValidationFailed extends ValidationState {
  final ValidationField field;

  ValidationFailed({@required this.field});
}

enum ValidationField { NONE, NAME, CONTACT_NUMBER, CITY }
