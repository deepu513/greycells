import 'package:greycells/constants/gender.dart';
import 'package:json_annotation/json_annotation.dart';

class HealthRecord {

// TODO: Move gender to patient parent class
  Gender gender;
  String readableGender;

  @JsonKey(name: "Width")
  int weightInKg;

  @JsonKey(name: "Height")
  int heightInCm;

  @JsonKey(name: "BloodGroup")
  int bloodGroup;

  @JsonKey(name: "BMI")
  int bmi;

  @JsonKey(name: "MedicalHistory")
  String medicalHistory;

  HealthRecord();
}
