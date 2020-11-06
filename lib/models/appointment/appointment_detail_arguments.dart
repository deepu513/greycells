import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/appointment/appointment.dart';

class AppointmentDetailArguments {
  final Appointment appointment;
  final UserType userType;

  AppointmentDetailArguments(this.appointment, this.userType);
}
