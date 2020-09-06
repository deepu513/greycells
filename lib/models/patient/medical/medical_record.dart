import 'package:greycells/bloc/picker/file_picker_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medical_record.g.dart';

@JsonSerializable(explicitToJson: true)
class MedicalRecord {

	@JsonKey(name: "Type")
  String type;

	@JsonKey(name: "FileUrl")
  String fileUrl;

	@JsonKey(name: "FileType")
  String fileType;

	@JsonKey(name: "Description")
  String description;

	@JsonKey(ignore: true)
	List<PickedFile> pickedFiles;

	MedicalRecord() {
		pickedFiles = List<PickedFile>();
	}

	factory MedicalRecord.fromJson(Map<String, dynamic> json) => _$MedicalRecordFromJson(json);

	  Map<String, dynamic> toJson() => _$MedicalRecordToJson(this);

}
