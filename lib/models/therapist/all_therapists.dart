import 'package:greycells/models/therapist/therapist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_therapists.g.dart';

@JsonSerializable(explicitToJson: true)
class AllTherapists {
  @JsonKey(name: "avaliableThrapist")
  List<Therapist> availableTherapists;

  @JsonKey(name: "totalrecords")
  int totalRecords;

  AllTherapists();

  factory AllTherapists.fromJson(Map<String, dynamic> json) =>
      _$AllTherapistsFromJson(json);
  Map<String, dynamic> toJson() => _$AllTherapistsToJson(this);
}
