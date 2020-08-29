import 'package:json_annotation/json_annotation.dart';
import 'package:mental_health/models/address/guardian_address.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  String houseNumber;
  String roadName;
  String city;
  String state;
  String country;
  String pincode;

  GuardianAddress guardianAddress;

  Address();

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
