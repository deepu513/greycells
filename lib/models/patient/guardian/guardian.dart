import 'package:greycells/constants/relationship.dart';
import 'package:greycells/models/patient/address/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guardian.g.dart';

@JsonSerializable(explicitToJson: true)
class Guardian {

  @JsonKey(ignore: true)
  Relationship relationShip;

  @JsonKey(name: "Relationship")
  String readableRelationship;

  @JsonKey(name: "FirstName")
  String firstName;

  @JsonKey(name: "LastName")
  String lastName;

  @JsonKey(name: "MobileNumber")
  String mobileNumber;

  @JsonKey(name: "Address")
  Address address;

  Guardian() {
    address = Address();
  }

  factory Guardian.fromJson(Map<String, dynamic> json) => _$GuardianFromJson(json);

    Map<String, dynamic> toJson() => _$GuardianToJson(this);
}
