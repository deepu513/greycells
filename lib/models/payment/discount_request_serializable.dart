import 'package:greycells/networking/serializable.dart';
import 'package:greycells/models/payment/discount_request.dart';

class DiscountRequestSerializable implements Serializable<DiscountRequest> {
  @override
  DiscountRequest fromJson(Map<String, dynamic> json) {
    return DiscountRequest.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(DiscountRequest request) {
    return request.toJson();
  }

  @override
  List<DiscountRequest> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray?.map((requestMap) =>
    requestMap == null ? null : fromJson(requestMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<DiscountRequest> requestList) {
    return requestList?.map((request) => request?.toJson())?.toList();
  }
}