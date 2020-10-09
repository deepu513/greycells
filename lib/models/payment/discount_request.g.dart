// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountRequest _$DiscountRequestFromJson(Map<String, dynamic> json) {
  return DiscountRequest()
    ..promoCode = json['Code'] as String
    ..userId = json['UserId'] as int;
}

Map<String, dynamic> _$DiscountRequestToJson(DiscountRequest instance) =>
    <String, dynamic>{
      'Code': instance.promoCode,
      'UserId': instance.userId,
    };
