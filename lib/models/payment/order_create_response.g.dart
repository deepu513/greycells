// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreateResponse _$OrderCreateResponseFromJson(Map<String, dynamic> json) {
  return OrderCreateResponse()
    ..paymentId = json['paymentId'] as int
    ..orderId = json['id'] as String
    ..razorPayAmount = json['amount'] as String
    ..result = json['result'] as bool;
}

Map<String, dynamic> _$OrderCreateResponseToJson(
        OrderCreateResponse instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'id': instance.orderId,
      'amount': instance.razorPayAmount,
      'result': instance.result,
    };
