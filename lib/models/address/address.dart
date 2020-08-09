import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  String houseNumber;
  String roadName;
  String city;
  String state;
  String country;
  String pincode;

  Address();

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

    Map<String, dynamic> toJson() => _$AddressToJson(this);
}