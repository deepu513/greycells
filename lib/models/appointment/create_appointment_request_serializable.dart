import 'package:greycells/models/appointment/create_appointment_request.dart';
import 'package:greycells/networking/serializable.dart';

class CreateAppointmentRequestSerializable
    implements Serializable<CreateAppointmentRequest> {
  @override
  CreateAppointmentRequest fromJson(Map<String, dynamic> json) {
    return CreateAppointmentRequest.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(CreateAppointmentRequest item) {
    return item.toJson();
  }

  @override
  List<CreateAppointmentRequest> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<CreateAppointmentRequest> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
