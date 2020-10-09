import 'package:greycells/models/payment/payment_verify.dart';
import 'package:greycells/networking/serializable.dart';

class PaymentVerifySerializable implements Serializable<PaymentVerify> {
  @override
  PaymentVerify fromJson(Map<String, dynamic> json) {
    return PaymentVerify.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(PaymentVerify paymentVerify) {
    return paymentVerify.toJson();
  }

  @override
  List<PaymentVerify> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((paymentVerifyMap) =>
            paymentVerifyMap == null ? null : fromJson(paymentVerifyMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<PaymentVerify> paymentVerifyList) {
    return paymentVerifyList
        ?.map((paymentVerify) => paymentVerify?.toJson())
        ?.toList();
  }
}
