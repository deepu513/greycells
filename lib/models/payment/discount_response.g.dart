// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountResponse _$DiscountResponseFromJson(Map<String, dynamic> json) {
  return DiscountResponse()
    ..result = json['result'] as bool
    ..discountId = json['discountId'] as int
    ..discountPercent = json['discountPercent'] as int
    ..promoCode = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$DiscountResponseToJson(DiscountResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'discountId': instance.discountId,
      'discountPercent': instance.discountPercent,
      'code': instance.promoCode,
      'message': instance.message,
    };
