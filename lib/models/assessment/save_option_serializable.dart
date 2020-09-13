import 'package:greycells/networking/serializable.dart';
import 'save_option_request.dart';

class SaveOptionRequestSerializable implements Serializable<SaveOptionRequest> {
  @override
  SaveOptionRequest fromJson(Map<String, dynamic> json) {
    return SaveOptionRequest.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(SaveOptionRequest request) {
    return request.toJson();
  }

  @override
  List<SaveOptionRequest> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((requestMap) => requestMap == null ? null : fromJson(requestMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<SaveOptionRequest> requestList) {
    return requestList?.map((request) => request?.toJson())?.toList();
  }
}
