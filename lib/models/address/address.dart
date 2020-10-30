import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  @JsonKey(name: "readable_Address")
  String readableAddress;

  @JsonKey(name: "city")
  String city;

  @JsonKey(name: "state")
  String state;

  @JsonKey(name: "country")
  String country;

  @JsonKey(name: "postalCode")
  String pincode;

  @JsonKey(ignore: true)
  String houseNumber;

  @JsonKey(ignore: true)
  String roadName;

  Address();

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
