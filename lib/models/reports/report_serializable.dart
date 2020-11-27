import 'package:greycells/models/reports/report.dart';
import 'package:greycells/networking/serializable.dart';

class ReportSerializable implements Serializable<Report> {
  @override
  Report fromJson(Map<String, dynamic> json) {
    return Report.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Report item) {
    return item.toJson();
  }

  @override
  List<Report> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((item) => item == null ? null : fromJson(item))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<Report> items) {
    return items?.map((item) => item?.toJson())?.toList();
  }
}
