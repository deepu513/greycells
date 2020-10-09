import 'package:json_annotation/json_annotation.dart';

part 'order_create_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderCreateResponse {
  @JsonKey(name: "id")
  String orderId;

  @JsonKey(name: "amount")
  String razorPayAmount;

  bool result;

  OrderCreateResponse();

  factory OrderCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderCreateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateResponseToJson(this);
}
