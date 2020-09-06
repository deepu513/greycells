import 'package:json_annotation/json_annotation.dart';

part 'health_record.g.dart';

@JsonSerializable(explicitToJson: true)
class HealthRecord {
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

  factory HealthRecord.fromJson(Map<String, dynamic> json) =>
      _$HealthRecordFromJson(json);

  Map<String, dynamic> toJson() => _$HealthRecordToJson(this);
}
