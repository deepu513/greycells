import 'package:json_annotation/json_annotation.dart';

part 'payment_verify.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentVerify {
  @JsonKey(name: "razorpay_payment_id")
  String razorPayPaymentId;

  @JsonKey(name: "razorpay_order_id")
  String razorPayOrderId;

  @JsonKey(name: "razorpay_signature")
  String razorPaySignature;

  @JsonKey(name: "DiscountId")
  int discountId;

  @JsonKey(name: "UserId")
  int userId;

  PaymentVerify();

  factory PaymentVerify.fromJson(Map<String, dynamic> json) =>
      _$PaymentVerifyFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentVerifyToJson(this);
}
