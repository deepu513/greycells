import 'package:greycells/constants/relationship.dart';
import 'package:greycells/models/address/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guardian.g.dart';

@JsonSerializable(explicitToJson: true)
class Guardian {

  @JsonKey(ignore: true)
  Relationship relationShip;

  @JsonKey(name: "relationship")
  String readableRelationship;

  @JsonKey(name: "firstName")
  String firstName;

  @JsonKey(name: "lastName")
  String lastName;

  @JsonKey(name: "mobileNumber")
  String mobileNumber;

  @JsonKey(ignore: true, name: "email")
  String email;

  @JsonKey(name: "address")
  Address address;

  Guardian() {
    address = Address();
  }

  factory Guardian.fromJson(Map<String, dynamic> json) => _$GuardianFromJson(json);

    Map<String, dynamic> toJson() => _$GuardianToJson(this);
}
