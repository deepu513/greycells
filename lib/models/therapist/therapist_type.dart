import 'package:json_annotation/json_annotation.dart';

part 'therapist_type.g.dart';

@JsonSerializable(explicitToJson: true)
class TherapistType {

  String name;
  String expertise;
  String specialisation;
  int id;

  TherapistType();

  factory TherapistType.fromJson(Map<String, dynamic> json) =>
      _$TherapistTypeFromJson(json);
  Map<String, dynamic> toJson() => _$TherapistTypeToJson(this);
}
