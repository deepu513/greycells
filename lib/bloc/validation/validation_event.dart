import 'package:mental_health/models/user/user.dart';

abstract class ValidationEvent {}

class ValidationValidateUser extends ValidationEvent {
  final User user;

  ValidationValidateUser({this.user});
}

class ValidationValidateContactNumber extends ValidationEvent {
  final String contactNumber;

  ValidationValidateContactNumber({this.contactNumber});

}
