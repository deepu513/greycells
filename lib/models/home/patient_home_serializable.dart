import 'package:greycells/models/home/patient_home.dart';
import 'package:greycells/networking/serializable.dart';

class HomeSerializable implements Serializable<PatientHome> {
  @override
  PatientHome fromJson(Map<String, dynamic> json) {
    return PatientHome.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(PatientHome home) {
    return home.toJson();
  }

  @override
  List<PatientHome> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((homeMap) => homeMap == null ? null : fromJson(homeMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<PatientHome> homeList) {
    return homeList?.map((home) => home?.toJson())?.toList();
  }
}
