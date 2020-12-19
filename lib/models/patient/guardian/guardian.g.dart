// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guardian.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Guardian _$GuardianFromJson(Map<String, dynamic> json) {
  return Guardian()
    ..readableRelationship = json['relationship'] as String
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..mobileNumber = json['mobileNumber'] as String
    ..email = json['email'] as String
    ..address = json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GuardianToJson(Guardian instance) => <String, dynamic>{
      'relationship': instance.readableRelationship,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'address': instance.address?.toJson(),
    };
