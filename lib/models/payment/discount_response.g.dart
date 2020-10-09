// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountResponse _$DiscountResponseFromJson(Map<String, dynamic> json) {
  return DiscountResponse()
    ..result = json['result'] as bool
    ..message = json['message'] as String
    ..discountId = json['discountId'] as int
    ..userId = json['userId'] as int
    ..promoCode = json['promoCode'] as String
    ..discountPercent = json['discountPercent'] as int;
}

Map<String, dynamic> _$DiscountResponseToJson(DiscountResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
      'discountId': instance.discountId,
      'userId': instance.userId,
      'promoCode': instance.promoCode,
      'discountPercent': instance.discountPercent,
    };
