import 'package:greycells/models/payment/discount_response.dart';
import 'package:greycells/networking/serializable.dart';

class DiscountResponseSerializable implements Serializable<DiscountResponse> {
  @override
  DiscountResponse fromJson(Map<String, dynamic> json) {
    return DiscountResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(DiscountResponse response) {
    return response.toJson();
  }

  @override
  List<DiscountResponse> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray?.map((responseMap) =>
    responseMap == null ? null : fromJson(responseMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<DiscountResponse> responseList) {
    return responseList?.map((response) => response?.toJson())?.toList();
  }
}