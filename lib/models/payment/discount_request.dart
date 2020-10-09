import 'package:json_annotation/json_annotation.dart';

part 'discount_request.g.dart';

@JsonSerializable(explicitToJson: true)
class DiscountRequest {
  @JsonKey(name: "Code")
  String promoCode;

  @JsonKey(name: "UserId")
  int userId;

  DiscountRequest();

  factory DiscountRequest.fromJson(Map<String, dynamic> json) =>
      _$DiscountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountRequestToJson(this);
}
