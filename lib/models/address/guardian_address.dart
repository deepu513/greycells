import 'package:json_annotation/json_annotation.dart';

part 'guardian_address.g.dart';

@JsonSerializable(explicitToJson: true)
class GuardianAddress {
  String houseNumber;
  String roadName;
  String city;
  String state;
  String country;
  String pincode;

  GuardianAddress();

  factory GuardianAddress.fromJson(Map<String, dynamic> json) =>
      _$GuardianAddressFromJson(json);

  Map<String, dynamic> toJson() => _$GuardianAddressToJson(this);
}
