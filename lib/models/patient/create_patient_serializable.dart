import 'package:greycells/models/patient/create_patient_response.dart';
import 'package:greycells/networking/serializable.dart';

class CreatePatientResponseSerializable
    implements Serializable<CreatePatientResponse> {
  @override
  CreatePatientResponse fromJson(Map<String, dynamic> json) {
    return CreatePatientResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(CreatePatientResponse patientResponse) {
    return patientResponse.toJson();
  }

  @override
  List<CreatePatientResponse> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((patientResponseMap) =>
            patientResponseMap == null ? null : fromJson(patientResponseMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<CreatePatientResponse> patientResponseList) {
    return patientResponseList
        ?.map((patientResponse) => patientResponse?.toJson())
        ?.toList();
  }
}
