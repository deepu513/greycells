import 'package:greycells/models/timeslot/timeslot_response.dart';
import 'package:greycells/networking/serializable.dart';

class TimeslotResponseSerializable implements Serializable<TimeslotResponse> {
  @override
  TimeslotResponse fromJson(Map<String, dynamic> json) {
    return TimeslotResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(TimeslotResponse item) {
    return item.toJson();
  }

  @override
  List<TimeslotResponse> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<TimeslotResponse> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
