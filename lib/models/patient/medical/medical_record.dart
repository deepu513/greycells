import 'package:json_annotation/json_annotation.dart';

part 'medical_record.g.dart';

@JsonSerializable(explicitToJson: true)
class MedicalRecord {

	@JsonKey(name : "PatientId")
	int patientId;

	@JsonKey(name: "fileId")
	int fileId;

	MedicalRecord() {
		patientId = 0;
	}

	factory MedicalRecord.fromJson(Map<String, dynamic> json) => _$MedicalRecordFromJson(json);

	  Map<String, dynamic> toJson() => _$MedicalRecordToJson(this);

}
