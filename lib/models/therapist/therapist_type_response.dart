import 'package:greycells/models/therapist/therapist_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'therapist_type_response.g.dart';

@JsonSerializable(explicitToJson: true)
class TherapistTypeResponse {
  List<TherapistType> therapytypes;

  TherapistTypeResponse();

  factory TherapistTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$TherapistTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TherapistTypeResponseToJson(this);
}
