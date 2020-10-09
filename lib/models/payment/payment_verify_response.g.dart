// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentVerifyResponse _$PaymentVerifyResponseFromJson(
    Map<String, dynamic> json) {
  return PaymentVerifyResponse()
    ..result = json['result'] as bool
    ..message = json['message'] as String;
}

Map<String, dynamic> _$PaymentVerifyResponseToJson(
        PaymentVerifyResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };
