// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as int
    ..username = json['username'] as String
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..mobileNumber = json['mobileNumber'] as String
    ..token = json['token'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobileNumber': instance.mobileNumber,
      'token': instance.token,
    };
