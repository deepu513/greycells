import 'package:greycells/models/home/therapist_home.dart';
import 'package:greycells/networking/serializable.dart';

class TherapistHomeSerializable implements Serializable<TherapistHome> {
  @override
  TherapistHome fromJson(Map<String, dynamic> json) {
    return TherapistHome.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(TherapistHome therapistHome) {
    return therapistHome.toJson();
  }

  @override
  List<TherapistHome> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<TherapistHome> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
