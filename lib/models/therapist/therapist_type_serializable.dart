import 'package:greycells/networking/serializable.dart';
import 'therapist_type_response.dart';

class TherapistTypeResponseSerializable
    implements Serializable<TherapistTypeResponse> {
  @override
  TherapistTypeResponse fromJson(Map<String, dynamic> json) {
    return TherapistTypeResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(TherapistTypeResponse item) {
    return item.toJson();
  }

  @override
  List<TherapistTypeResponse> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<TherapistTypeResponse> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
