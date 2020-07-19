import 'package:json_annotation/json_annotation.dart';
import 'package:mental_health/models/city/city.dart';
import 'package:mental_health/models/user/user_type.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {

  int id;
  String name;
  String contactNumber;
  String profilePictureUrl;

  UserType userType;

  City city;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
