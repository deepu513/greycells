// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address()
    ..houseNumber = json['houseNumber'] as String
    ..roadName = json['roadName'] as String
    ..city = json['city'] as String
    ..state = json['state'] as String
    ..country = json['country'] as String
    ..pincode = json['pincode'] as String
    ..guardianAddress = json['guardianAddress'] == null
        ? null
        : GuardianAddress.fromJson(
            json['guardianAddress'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'houseNumber': instance.houseNumber,
      'roadName': instance.roadName,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'pincode': instance.pincode,
      'guardianAddress': instance.guardianAddress?.toJson(),
    };
