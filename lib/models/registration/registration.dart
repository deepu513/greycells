import 'package:greycells/constants/user_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registration.g.dart';

@JsonSerializable(explicitToJson: true)
class Registration {
  @JsonKey(name: "FirstName")
  String firstName;

  @JsonKey(name: "LastName")
  String lastName;

  @JsonKey(name: "MobileNumber")
  String mobileNumber;

  @JsonKey(name: "Email")
  String email;

  @JsonKey(name: "Password")
  String password;

  @JsonKey(name: "DeviceId", disallowNullValue: true)
  String deviceId;

  @JsonKey(
      name: "UserType", disallowNullValue: true)
  UserType userType;

  @JsonKey(ignore: true)
  String confirmPassword;

  Registration() {
    deviceId = "";
    userType = UserType.PATIENT;
  }

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationToJson(this);
}
