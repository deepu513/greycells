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
    ..therapistType = json['therapyType'] == null
        ? null
        : TherapistType.fromJson(json['therapyType'] as Map<String, dynamic>)
    ..charges = (json['charges'] as List)
        ?.map((e) => e == null
            ? null
            : MeetingCharge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..meetingDuration = json['meetingDuration'] == null
        ? null
        : MeetingDuration.fromJson(
            json['meetingDuration'] as Map<String, dynamic>)
    ..spokenLanguage = json['spokenLanguage'] as String
    ..medicalCouncil = json['medicalCouncil'] as String
    ..disorder = json['disorderType'] == null
        ? null
        : Disorder.fromJson(json['disorderType'] as Map<String, dynamic>);
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
  val['therapyType'] = instance.therapistType?.toJson();
  val['charges'] = instance.charges?.map((e) => e?.toJson())?.toList();
  val['meetingDuration'] = instance.meetingDuration?.toJson();
  val['spokenLanguage'] = instance.spokenLanguage;
  val['medicalCouncil'] = instance.medicalCouncil;
  val['disorderType'] = instance.disorder?.toJson();
  return val;
}
