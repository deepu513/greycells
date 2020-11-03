import 'package:greycells/models/timeslot/timeslot_request.dart';
import 'package:greycells/networking/serializable.dart';

class TimeslotRequestSerializable implements Serializable<TimeslotRequest> {
  @override
  TimeslotRequest fromJson(Map<String, dynamic> json) {
    return TimeslotRequest.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(TimeslotRequest item) {
    return item.toJson();
  }

  @override
  List<TimeslotRequest> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<TimeslotRequest> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
