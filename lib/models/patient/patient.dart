import 'package:greycells/constants/gender.dart';
import 'package:greycells/models/patient/address/address.dart';
import 'package:greycells/models/patient/guardian/guardian.dart';
import 'package:greycells/models/patient/health/health_record.dart';
import 'package:greycells/models/patient/medical/medical_record.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable(explicitToJson: true)
class Patient {
  @JsonKey(name: "Gender")
  int genderValue;

  @JsonKey(name: "CustomerID")
  int id;

  @JsonKey(name: "AlternativeNumber")
  String alternativeNumber;

  @JsonKey(name: "FileId")
  String profilePicId;

  @JsonKey(name: "IsMinor")
  bool isMinor;

  @JsonKey(name: "Address")
  /// Not a atomic value
  Address address;

  @JsonKey(name: "isEligibleForTest")
  bool isEligibleForTest;

  @JsonKey(name: "HealthRecord")
  /// Not a atomic value
  HealthRecord healthRecord;

  @JsonKey(name: "MedicalRecord")
  /// Not a atomic value
  MedicalRecord medicalRecord;

  @JsonKey(name: "Guardian")
  /// Not a atomic value
  Guardian guardian;

  @JsonKey(name: "PlaceOfBirth")
  String placeOfBirth;

  @JsonKey(name: "DateOfBirth")
  String dateOfBirth;

  @JsonKey(name: "TimeOfBirth")
  String timeOfBirth;

  // Date of birth
  @JsonKey(ignore: true)
  String dayPart;

  @JsonKey(ignore: true)
  String monthPart;

  @JsonKey(ignore: true)
  String yearPart;

  // Time of birth
  @JsonKey(ignore: true)
  String hourPart;

  @JsonKey(ignore: true)
  String minutePart;

  // AM PM
  @JsonKey(ignore: true)
  String a;

  @JsonKey(ignore: true)
  Gender gender;

  @JsonKey(ignore: true)
  String readableGender;

  Patient();

  factory Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);

    Map<String, dynamic> toJson() => _$PatientToJson(this);
}
