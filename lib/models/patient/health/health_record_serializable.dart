import 'package:greycells/models/patient/health/health_record.dart';
import 'package:greycells/networking/serializable.dart';

class HealthRecordSerializable implements Serializable<HealthRecord> {
  @override
  HealthRecord fromJson(Map<String, dynamic> json) {
    return HealthRecord.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(HealthRecord healthRecord) {
    return healthRecord.toJson();
  }

  @override
  List<HealthRecord> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((healthRecordMap) =>
            healthRecordMap == null ? null : fromJson(healthRecordMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<HealthRecord> healthRecordList) {
    return healthRecordList
        ?.map((healthRecord) => healthRecord?.toJson())
        ?.toList();
  }
}
