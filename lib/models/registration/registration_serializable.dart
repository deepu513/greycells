import 'package:greycells/models/registration/registration.dart';
import 'package:greycells/networking/serializable.dart';

class RegistrationSerializable implements Serializable<Registration> {
  @override
  Registration fromJson(Map<String, dynamic> json) {
    return Registration.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Registration registration) {
    return registration.toJson();
  }

  @override
  List<Registration> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray?.map((registrationMap) =>
    registrationMap == null ? null : fromJson(registrationMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<Registration> registrationList) {
    return registrationList?.map((registration) => registration?.toJson())?.toList();
  }
}