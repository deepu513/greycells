import 'package:greycells/models/patient/medical/medical_record.dart';
import 'package:greycells/networking/serializable.dart';

class MedicalRecordSerializable implements Serializable<MedicalRecord> {
  @override
  MedicalRecord fromJson(Map<String, dynamic> json) {
    return MedicalRecord.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(MedicalRecord medicalRecord) {
    return medicalRecord.toJson();
  }

  @override
  List<MedicalRecord> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((medicalRecordMap) =>
            medicalRecordMap == null ? null : fromJson(medicalRecordMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<MedicalRecord> medicalRecordList) {
    return medicalRecordList
        ?.map((medicalRecord) => medicalRecord?.toJson())
        ?.toList();
  }
}
