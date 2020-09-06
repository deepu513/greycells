// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address()
    ..readableAddress = json['Readable_Address'] as String
    ..city = json['City'] as String
    ..state = json['State'] as String
    ..country = json['Country'] as String
    ..pincode = json['PostalCode'] as String;
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'Readable_Address': instance.readableAddress,
      'City': instance.city,
      'State': instance.state,
      'Country': instance.country,
      'PostalCode': instance.pincode,
    };
