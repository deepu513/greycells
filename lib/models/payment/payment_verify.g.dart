// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_verify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentVerify _$PaymentVerifyFromJson(Map<String, dynamic> json) {
  return PaymentVerify()
    ..razorPayPaymentId = json['razorpay_payment_id'] as String
    ..razorPayOrderId = json['razorpay_order_id'] as String
    ..razorPaySignature = json['razorpay_signature'] as String
    ..discountId = json['DiscountId'] as int
    ..userId = json['UserId'] as int;
}

Map<String, dynamic> _$PaymentVerifyToJson(PaymentVerify instance) =>
    <String, dynamic>{
      'razorpay_payment_id': instance.razorPayPaymentId,
      'razorpay_order_id': instance.razorPayOrderId,
      'razorpay_signature': instance.razorPaySignature,
      'DiscountId': instance.discountId,
      'UserId': instance.userId,
    };
