// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_charge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentCharge _$AppointmentChargeFromJson(Map<String, dynamic> json) {
  return AppointmentCharge()
    ..meetingTypeId = json['meetingTypeId'] as int
    ..meetingType = json['meetingType'] == null
        ? null
        : MeetingType.fromJson(json['meetingType'] as Map<String, dynamic>)
    ..amount = json['amount'] as int
    ..id = json['id'] as int;
}

Map<String, dynamic> _$AppointmentChargeToJson(AppointmentCharge instance) =>
    <String, dynamic>{
      'meetingTypeId': instance.meetingTypeId,
      'meetingType': instance.meetingType?.toJson(),
      'amount': instance.amount,
      'id': instance.id,
    };
