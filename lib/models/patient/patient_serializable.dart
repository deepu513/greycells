import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/networking/serializable.dart';

class PatientSerializable implements Serializable<Patient> {
  @override
  Patient fromJson(Map<String, dynamic> json) {
    return Patient.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Patient patient) {
    return patient.toJson();
  }

  @override
  List<Patient> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((patientMap) => patientMap == null ? null : fromJson(patientMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<Patient> patientList) {
    return patientList?.map((patient) => patient?.toJson())?.toList();
  }
}
