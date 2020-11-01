import 'package:greycells/models/therapist/all_therapists.dart';
import 'package:greycells/networking/serializable.dart';

class AllTherapistsSerializable implements Serializable<AllTherapists> {
  @override
  AllTherapists fromJson(Map<String, dynamic> json) {
    return AllTherapists.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(AllTherapists item) {
    return item.toJson();
  }

  @override
  List<AllTherapists> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<AllTherapists> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
