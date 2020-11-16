import 'package:json_annotation/json_annotation.dart';

part 'create_appointment_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateAppointmentRequest {
  int therapistId;

  int patientId;

  int duration;

  String comments;

  int timeslotId;

  @JsonKey(name: "Paymentid")
  int paymentId;

  @JsonKey(name: "MeetingTypeId")
  int meetingTypeId;

  @JsonKey(name: "ChargeId")
  int chargeId;

  @JsonKey(ignore: true)
  DateTime appointmentDateTime;

  CreateAppointmentRequest();

  factory CreateAppointmentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAppointmentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAppointmentRequestToJson(this);
}
