import 'package:json_annotation/json_annotation.dart';

part 'discount_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DiscountResponse {
  bool result;

  int discountId;
  int discountPercent;

  @JsonKey(name: "code")
  String promoCode;

  String message;

  DiscountResponse();

  factory DiscountResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountResponseToJson(this);
}
