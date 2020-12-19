import 'package:greycells/models/patient/update_patient_request.dart';
import 'package:greycells/networking/serializable.dart';

class UpdatePatientRequestSerializable
    implements Serializable<UpdatePatientRequest> {
  @override
  UpdatePatientRequest fromJson(Map<String, dynamic> json) {
    return UpdatePatientRequest.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(UpdatePatientRequest item) {
    return item.toJson();
  }

  @override
  List<UpdatePatientRequest> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<UpdatePatientRequest> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
