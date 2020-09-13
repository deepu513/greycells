import 'package:json_annotation/json_annotation.dart';

part 'create_patient_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CreatePatientResponse {
  int id;

  CreatePatientResponse();

  factory CreatePatientResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePatientResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePatientResponseToJson(this);
}
