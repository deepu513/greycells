import 'package:greycells/constants/user_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int id;
  String email;
  String firstName;
  String lastName;
  String mobileNumber;
  UserType userType;
  String token;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
