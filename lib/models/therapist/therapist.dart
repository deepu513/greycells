import 'package:greycells/models/file/file.dart';
import 'package:greycells/models/therapist/disorder.dart';
import 'package:greycells/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'therapist.g.dart';

@JsonSerializable(explicitToJson: true)
class Therapist {
  @JsonKey(includeIfNull: false)
  int id;

  @JsonKey(name: "gender")
  int genderValue;

  @JsonKey(name: "customerID")
  int customerId;

  @JsonKey(name: "customer", includeIfNull: false)
  User user;

  @JsonKey(name: "fileId")
  int profilePicId;

  @JsonKey(name: "file")
  File file;

  @JsonKey(name: "totalExperince")
  int totalExperience;

  @JsonKey(name: "qualication")
  String qualification;

  String spokenLanguage;

  String medicalCouncil;

  @JsonKey(name: "disorderType")
  Disorder disorder;

  Therapist();

  factory Therapist.fromJson(Map<String, dynamic> json) =>
      _$TherapistFromJson(json);
  Map<String, dynamic> toJson() => _$TherapistToJson(this);

// {
//             "genderType": 0,
//             "meetingDuration": null,
//         }
}