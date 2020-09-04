import 'package:json_annotation/json_annotation.dart';
import 'package:mental_health/constants/user_type.dart';

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

  @JsonKey(name: "DeviceId")
  String deviceId;

  @JsonKey(name: "UserType")
  UserType userType;

  @JsonKey(ignore: true)
  String confirmPassword;

  Registration();

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationToJson(this);
}
