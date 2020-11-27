import 'package:greycells/models/file/file.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medical_record.g.dart';

@JsonSerializable(explicitToJson: true)
class MedicalRecord {
  @JsonKey(name: "PatientId")
  int patientId;

  @JsonKey(name: "fileId")
  int fileId;

  @JsonKey(name: "file", includeIfNull: false)
  File file;

  @JsonKey(includeIfNull: false)
  int id;

  MedicalRecord() {
    patientId = 0;
  }

  factory MedicalRecord.fromJson(Map<String, dynamic> json) =>
      _$MedicalRecordFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalRecordToJson(this);
}
