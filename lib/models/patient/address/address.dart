import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  @JsonKey(name: "Readable_Address")
  String readableAddress;

  @JsonKey(name: "City")
  String city;

  @JsonKey(name: "State")
  String state;

  @JsonKey(name: "Country")
  String country;

  @JsonKey(name: "PostalCode")
  String pincode;

  Address();

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
