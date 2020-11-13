import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/models/therapist/charge.dart';
import 'package:greycells/models/therapist/therapist.dart';
import 'package:greycells/models/timeslot/timeslot.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable(explicitToJson: true)
class Appointment {
  int therapistId;
  int patientId;
  int duration;
  int paymentId;
  int chargeId;
  int id;
  int timeSlotId;
  int meetingTypeId;
  int status;
  int paymentID;
  String date;
  String comments;
  Therapist therapist;
  Patient patient;
  MeetingCharge charge;
  Timeslot timeSlot;
  //           "payment": null,

  Appointment();

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
