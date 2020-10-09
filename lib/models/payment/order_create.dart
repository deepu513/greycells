import 'package:greycells/models/payment/payment_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_create.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderCreate {
  @JsonKey(name: "Amount")
  int amount;

  @JsonKey(name: "Type")
  PaymentType type;

  @JsonKey(name: "UserId")
  int userId;

  OrderCreate();

  factory OrderCreate.fromJson(Map<String, dynamic> json) =>
      _$OrderCreateFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateToJson(this);
}
