// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timeslot _$TimeslotFromJson(Map<String, dynamic> json) {
  return Timeslot()
    ..startTime = json['startTime'] as String
    ..endTime = json['endTime'] as String
    ..id = json['id'] as int;
}

Map<String, dynamic> _$TimeslotToJson(Timeslot instance) => <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'id': instance.id,
    };
