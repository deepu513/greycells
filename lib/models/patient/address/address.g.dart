// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address()
    ..readableAddress = json['readable_Address'] as String
    ..city = json['city'] as String
    ..state = json['state'] as String
    ..country = json['country'] as String
    ..pincode = json['postalCode'] as String;
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'readable_Address': instance.readableAddress,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'postalCode': instance.pincode,
    };
