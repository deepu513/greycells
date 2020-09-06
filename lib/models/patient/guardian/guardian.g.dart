// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guardian.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Guardian _$GuardianFromJson(Map<String, dynamic> json) {
  return Guardian()
    ..readableRelationship = json['Relationship'] as String
    ..firstName = json['FirstName'] as String
    ..lastName = json['LastName'] as String
    ..mobileNumber = json['MobileNumber'] as String
    ..address = json['Address'] == null
        ? null
        : Address.fromJson(json['Address'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GuardianToJson(Guardian instance) => <String, dynamic>{
      'Relationship': instance.readableRelationship,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'MobileNumber': instance.mobileNumber,
      'Address': instance.address?.toJson(),
    };
