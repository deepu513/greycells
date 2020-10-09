import 'package:greycells/models/payment/payment_verify_response.dart';
import 'package:greycells/networking/serializable.dart';

class PaymentVerifyResponseSerializable
    implements Serializable<PaymentVerifyResponse> {
  @override
  PaymentVerifyResponse fromJson(Map<String, dynamic> json) {
    return PaymentVerifyResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(PaymentVerifyResponse verifyResponse) {
    return verifyResponse.toJson();
  }

  @override
  List<PaymentVerifyResponse> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((verifyResponseMap) =>
            verifyResponseMap == null ? null : fromJson(verifyResponseMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<PaymentVerifyResponse> verifyResponseList) {
    return verifyResponseList
        ?.map((verifyResponse) => verifyResponse?.toJson())
        ?.toList();
  }
}
