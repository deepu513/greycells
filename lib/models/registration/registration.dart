import 'package:json_annotation/json_annotation.dart';

part 'registration.g.dart';

@JsonSerializable(explicitToJson: true)
class Registration  {
  String firstName;
  String lastName;
  String mobileNumber;
  String email;
  String password;

  @JsonKey(ignore: true)
  String confirmPassword;

  Registration();

  factory Registration.fromJson(Map<String, dynamic> json) => _$RegistrationFromJson(json);

    Map<String, dynamic> toJson() => _$RegistrationToJson(this);
}