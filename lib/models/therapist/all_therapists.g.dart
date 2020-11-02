// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_therapists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllTherapists _$AllTherapistsFromJson(Map<String, dynamic> json) {
  return AllTherapists()
    ..availableTherapists = (json['avaliableThrapist'] as List)
        ?.map((e) =>
            e == null ? null : Therapist.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalRecords = json['totalrecords'] as int;
}

Map<String, dynamic> _$AllTherapistsToJson(AllTherapists instance) =>
    <String, dynamic>{
      'avaliableThrapist':
          instance.availableTherapists?.map((e) => e?.toJson())?.toList(),
      'totalrecords': instance.totalRecords,
    };
