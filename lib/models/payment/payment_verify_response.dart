import 'package:json_annotation/json_annotation.dart';

part 'payment_verify_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentVerifyResponse {
  bool result;
  String message;

  PaymentVerifyResponse();

  factory PaymentVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentVerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentVerifyResponseToJson(this);
}
