import 'package:json_annotation/json_annotation.dart';

part 'health_record.g.dart';

@JsonSerializable(explicitToJson: true)
class HealthRecord {
  @JsonKey(name: "width")
  int weightInKg;

  @JsonKey(name: "height", toJson: _heightToJson, fromJson: _heightFromJson)
  int heightInCm;

  @JsonKey(name: "bloodGroup")
  int bloodGroup;

  @JsonKey(name: "bmi")
  int bmi;

  @JsonKey(name: "medicalHistory")
  String medicalHistory;

  HealthRecord();

  factory HealthRecord.fromJson(Map<String, dynamic> json) =>
      _$HealthRecordFromJson(json);

  Map<String, dynamic> toJson() => _$HealthRecordToJson(this);

  static String _heightToJson(int height) {
    return height.toString();
  }

  static int _heightFromJson(String height) {
    return int.parse(height);
  }
}
