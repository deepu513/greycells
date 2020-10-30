// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingCharge _$MeetingChargeFromJson(Map<String, dynamic> json) {
  return MeetingCharge()
    ..amount = json['amount'] as int
    ..chargeId = json['chargeId'] as int
    ..meetingTypeId = json['meetingTypeId'] as int
    ..meetingType = json['meetingType'] as String;
}

Map<String, dynamic> _$MeetingChargeToJson(MeetingCharge instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'chargeId': instance.chargeId,
      'meetingTypeId': instance.meetingTypeId,
      'meetingType': instance.meetingType,
    };
