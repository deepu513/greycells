import 'package:greycells/bloc/picker/file_picker_bloc.dart';
import 'package:greycells/constants/gender.dart';
import 'package:greycells/models/address/address.dart';
import 'package:greycells/models/file/file.dart';
import 'package:greycells/models/patient/guardian/guardian.dart';
import 'package:greycells/models/patient/health/health_record.dart';
import 'package:greycells/models/patient/medical/medical_record.dart';
import 'package:greycells/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable(explicitToJson: true)
class Patient {
  @JsonKey(includeIfNull: false)
  int id;

  @JsonKey(name: "gender")
  int genderValue;

  @JsonKey(name: "customerID")
  int customerId;

  @JsonKey(name: "customer", includeIfNull: false)
  User user;

  @JsonKey(name: "alternativeNumber")
  String alternativeNumber;

  @JsonKey(name: "fileId")
  int profilePicId;

  @JsonKey(name: "file")
  File file;

  @JsonKey(ignore: true)
  String localProfilePicFilePath;

  @JsonKey(name: "IsMinor", includeIfNull: false)
  bool isMinor = true;

  /// Not a atomic value
  Address address;

  @JsonKey(name: "isEligibleForTest")
  bool isEligibleForTest;

  /// Not a atomic value
  HealthRecord healthRecord;

  /// Not a atomic value
  @JsonKey(name: "guardian")
  Guardian guardian;

  @JsonKey(name: "placeOfBirth")
  String placeOfBirth;

  @JsonKey(name: "dateOfBirth")
  String dateOfBirth;

  @JsonKey(name: "timeOfBirth")
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

  @JsonKey(name: "medicalRecord")
  List<MedicalRecord> medicalRecords;

  @JsonKey(ignore: true)
  List<PickedFile> pickedFiles;

  @JsonKey(includeIfNull: false)
  int noOfAppointments;

  Patient() {
    pickedFiles = List<PickedFile>();
    medicalRecords = List<MedicalRecord>();
  }

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
