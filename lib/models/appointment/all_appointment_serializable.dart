import 'package:greycells/models/appointment/all_appointment_response.dart';
import 'package:greycells/networking/serializable.dart';

class AllAppointmentResponseSerializable
    implements Serializable<AllAppointmentsResponse> {
  @override
  AllAppointmentsResponse fromJson(Map<String, dynamic> json) {
    return AllAppointmentsResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(AllAppointmentsResponse item) {
    return item.toJson();
  }

  @override
  List<AllAppointmentsResponse> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<AllAppointmentsResponse> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
