// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient()
    ..id = json['id'] as int
    ..genderValue = json['Gender'] as int
    ..customerId = json['CustomerID'] as int
    ..alternativeNumber = json['AlternativeNumber'] as String
    ..profilePicId = json['FileId'] as int
    ..isMinor = json['IsMinor'] as bool
    ..address = json['Address'] == null
        ? null
        : Address.fromJson(json['Address'] as Map<String, dynamic>)
    ..isEligibleForTest = json['isEligibleForTest'] as bool
    ..healthRecord = json['HealthRecord'] == null
        ? null
        : HealthRecord.fromJson(json['HealthRecord'] as Map<String, dynamic>)
    ..guardian = json['Guardian'] == null
        ? null
        : Guardian.fromJson(json['Guardian'] as Map<String, dynamic>)
    ..placeOfBirth = json['PlaceOfBirth'] as String
    ..dateOfBirth = json['DateOfBirth'] as String
    ..timeOfBirth = json['TimeOfBirth'] as String
    ..medicalRecords = (json['MedicalRecord'] as List)
        ?.map((e) => e == null
            ? null
            : MedicalRecord.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PatientToJson(Patient instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['Gender'] = instance.genderValue;
  val['CustomerID'] = instance.customerId;
  val['AlternativeNumber'] = instance.alternativeNumber;
  val['FileId'] = instance.profilePicId;
  val['IsMinor'] = instance.isMinor;
  val['Address'] = instance.address?.toJson();
  val['isEligibleForTest'] = instance.isEligibleForTest;
  val['HealthRecord'] = instance.healthRecord?.toJson();
  val['Guardian'] = instance.guardian?.toJson();
  val['PlaceOfBirth'] = instance.placeOfBirth;
  val['DateOfBirth'] = instance.dateOfBirth;
  val['TimeOfBirth'] = instance.timeOfBirth;
  val['MedicalRecord'] =
      instance.medicalRecords?.map((e) => e?.toJson())?.toList();
  return val;
}
