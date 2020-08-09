// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registration _$RegistrationFromJson(Map<String, dynamic> json) {
  return Registration()
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..mobileNumber = json['mobileNumber'] as String
    ..email = json['email'] as String
    ..password = json['password'] as String;
}

Map<String, dynamic> _$RegistrationToJson(Registration instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'password': instance.password,
    };
