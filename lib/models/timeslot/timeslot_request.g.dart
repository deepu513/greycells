// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeslotRequest _$TimeslotRequestFromJson(Map<String, dynamic> json) {
  return TimeslotRequest()
    ..therapistId = json['therapistId'] as int
    ..date = json['date'] as String;
}

Map<String, dynamic> _$TimeslotRequestToJson(TimeslotRequest instance) =>
    <String, dynamic>{
      'therapistId': instance.therapistId,
      'date': instance.date,
    };
