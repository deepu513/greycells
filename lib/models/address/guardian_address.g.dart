// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guardian_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardianAddress _$GuardianAddressFromJson(Map<String, dynamic> json) {
  return GuardianAddress()
    ..houseNumber = json['houseNumber'] as String
    ..roadName = json['roadName'] as String
    ..city = json['city'] as String
    ..state = json['state'] as String
    ..country = json['country'] as String
    ..pincode = json['pincode'] as String;
}

Map<String, dynamic> _$GuardianAddressToJson(GuardianAddress instance) =>
    <String, dynamic>{
      'houseNumber': instance.houseNumber,
      'roadName': instance.roadName,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'pincode': instance.pincode,
    };
