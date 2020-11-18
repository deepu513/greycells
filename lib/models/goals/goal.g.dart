// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return Goal()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..goalsTypes = (json['goalsTypes'] as List)
        ?.map((e) =>
            e == null ? null : GoalType.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'goalsTypes': instance.goalsTypes?.map((e) => e?.toJson())?.toList(),
    };
