import 'package:greycells/models/assessment/assessment_response.dart';
import 'package:greycells/networking/serializable.dart';

class AssessmentResponseSerializable
    implements Serializable<AssessmentResponse> {
  @override
  AssessmentResponse fromJson(Map<String, dynamic> json) {
    return AssessmentResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(AssessmentResponse item) {
    return item.toJson();
  }

  @override
  List<AssessmentResponse> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<AssessmentResponse> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
