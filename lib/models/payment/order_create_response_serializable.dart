import 'package:greycells/models/payment/order_create_response.dart';
import 'package:greycells/networking/serializable.dart';

class OrderCreateResponseSerializable
    implements Serializable<OrderCreateResponse> {
  @override
  OrderCreateResponse fromJson(Map<String, dynamic> json) {
    return OrderCreateResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(OrderCreateResponse orderCreateResponse) {
    return orderCreateResponse.toJson();
  }

  @override
  List<OrderCreateResponse> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((orderCreateResponseMap) => orderCreateResponseMap == null
            ? null
            : fromJson(orderCreateResponseMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<OrderCreateResponse> orderCreateResponseList) {
    return orderCreateResponseList
        ?.map((orderCreateResponse) => orderCreateResponse?.toJson())
        ?.toList();
  }
}
