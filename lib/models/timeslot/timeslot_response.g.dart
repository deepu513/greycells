// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslot_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeslotResponse _$TimeslotResponseFromJson(Map<String, dynamic> json) {
  return TimeslotResponse()
    ..timeslots = (json['avaliableTimeSlots'] as List)
        ?.map((e) =>
            e == null ? null : Timeslot.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TimeslotResponseToJson(TimeslotResponse instance) =>
    <String, dynamic>{
      'avaliableTimeSlots':
          instance.timeslots?.map((e) => e?.toJson())?.toList(),
    };
