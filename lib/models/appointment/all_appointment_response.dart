import 'package:greycells/models/appointment/appointment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_appointment_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AllAppointmentsResponse {
  @JsonKey(name: "upappointments")
  List<Appointment> appointments;

  AllAppointmentsResponse();

  factory AllAppointmentsResponse.fromJson(Map<String, dynamic> json) =>
      _$AllAppointmentsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllAppointmentsResponseToJson(this);
}
