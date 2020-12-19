import 'package:greycells/models/address/address.dart';
import 'package:greycells/models/patient/guardian/guardian.dart';
import 'package:greycells/models/patient/health/health_record.dart';
import 'package:greycells/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_patient_request.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdatePatientRequest {
  int id;

  @JsonKey(name: "FileId")
  int fileId;

  @JsonKey(name: "customer")
  User user;

  HealthRecord healthRecord;

  Address address;

  Guardian guardian;

  UpdatePatientRequest();

  factory UpdatePatientRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePatientRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePatientRequestToJson(this);
}
