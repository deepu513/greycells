import 'package:greycells/models/therapist/charge.dart';
import 'package:greycells/models/therapist/therapist.dart';

class AppointmentDateSelectionArguments {
  final Therapist therapist;
  final MeetingCharge selectedMeeting;

  AppointmentDateSelectionArguments(this.therapist, this.selectedMeeting);
}
