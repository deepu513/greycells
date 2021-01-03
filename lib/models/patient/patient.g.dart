// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient()
    ..id = json['id'] as int
    ..genderValue = json['gender'] as int
    ..customerId = json['customerID'] as int
    ..user = json['customer'] == null
        ? null
        : User.fromJson(json['customer'] as Map<String, dynamic>)
    ..alternativeNumber = json['alternativeNumber'] as String
    ..profilePicId = json['fileId'] as int
    ..file = json['file'] == null
        ? null
        : File.fromJson(json['file'] as Map<String, dynamic>)
    ..isMinor = json['IsMinor'] as bool
    ..address = json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>)
    ..isEligibleForTest = json['isEligibleForTest'] as bool
    ..healthRecord = json['healthRecord'] == null
        ? null
        : HealthRecord.fromJson(json['healthRecord'] as Map<String, dynamic>)
    ..guardian = json['guardian'] == null
        ? null
        : Guardian.fromJson(json['guardian'] as Map<String, dynamic>)
    ..placeOfBirth = json['placeOfBirth'] as String
    ..dateOfBirth = json['dateOfBirth'] as String
    ..timeOfBirth = json['timeOfBirth'] as String
    ..medicalRecords = (json['medicalRecord'] as List)
        ?.map((e) => e == null
            ? null
            : MedicalRecord.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..noOfAppointments = json['noOfAppointments'] as int
    ..assessmentCharge = json['assessmentCharge'] as String
    ..cancellationWindow = json['cancellationWindow'] as String;
}

Map<String, dynamic> _$PatientToJson(Patient instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['gender'] = instance.genderValue;
  val['customerID'] = instance.customerId;
  writeNotNull('customer', instance.user?.toJson());
  val['alternativeNumber'] = instance.alternativeNumber;
  val['fileId'] = instance.profilePicId;
  val['file'] = instance.file?.toJson();
  writeNotNull('IsMinor', instance.isMinor);
  val['address'] = instance.address?.toJson();
  val['isEligibleForTest'] = instance.isEligibleForTest;
  val['healthRecord'] = instance.healthRecord?.toJson();
  val['guardian'] = instance.guardian?.toJson();
  val['placeOfBirth'] = instance.placeOfBirth;
  val['dateOfBirth'] = instance.dateOfBirth;
  val['timeOfBirth'] = instance.timeOfBirth;
  val['medicalRecord'] =
      instance.medicalRecords?.map((e) => e?.toJson())?.toList();
  writeNotNull('noOfAppointments', instance.noOfAppointments);
  writeNotNull('assessmentCharge', instance.assessmentCharge);
  writeNotNull('cancellationWindow', instance.cancellationWindow);
  return val;
}
