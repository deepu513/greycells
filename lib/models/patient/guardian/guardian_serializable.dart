import 'package:greycells/models/patient/guardian/guardian.dart';
import 'package:greycells/networking/serializable.dart';

class GuardianSerializable implements Serializable<Guardian> {
  @override
  Guardian fromJson(Map<String, dynamic> json) {
    return Guardian.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Guardian guardian) {
    return guardian.toJson();
  }

  @override
  List<Guardian> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray?.map((guardianMap) =>
    guardianMap == null ? null : fromJson(guardianMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<Guardian> guardianList) {
    return guardianList?.map((guardian) => guardian?.toJson())?.toList();
  }
}