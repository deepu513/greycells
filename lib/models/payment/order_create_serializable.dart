import 'package:greycells/models/payment/order_create.dart';
import 'package:greycells/networking/serializable.dart';

class OrderCreateSerializable implements Serializable<OrderCreate> {
  @override
  OrderCreate fromJson(Map<String, dynamic> json) {
    return OrderCreate.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(OrderCreate orderCreate) {
    return orderCreate.toJson();
  }

  @override
  List<OrderCreate> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((orderCreateMap) =>
            orderCreateMap == null ? null : fromJson(orderCreateMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<OrderCreate> orderCreateList) {
    return orderCreateList
        ?.map((orderCreate) => orderCreate?.toJson())
        ?.toList();
  }
}
