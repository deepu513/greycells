// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'therapist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Therapist _$TherapistFromJson(Map<String, dynamic> json) {
  return Therapist()
    ..id = json['id'] as int
    ..genderValue = json['gender'] as int
    ..customerId = json['customerID'] as int
    ..user = json['customer'] == null
        ? null
        : User.fromJson(json['customer'] as Map<String, dynamic>)
    ..profilePicId = json['fileId'] as int
    ..file = json['file'] == null
        ? null
        : File.fromJson(json['file'] as Map<String, dynamic>)
    ..totalExperience = json['totalExperince'] as int
    ..qualification = json['qualication'] as String
    ..spokenLanguage = json['spokenLanguage'] as String
    ..medicalCouncil = json['medicalCouncil'] as String;
}

Map<String, dynamic> _$TherapistToJson(Therapist instance) {
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
  val['fileId'] = instance.profilePicId;
  val['file'] = instance.file?.toJson();
  val['totalExperince'] = instance.totalExperience;
  val['qualication'] = instance.qualification;
  val['spokenLanguage'] = instance.spokenLanguage;
  val['medicalCouncil'] = instance.medicalCouncil;
  return val;
}
