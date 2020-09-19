// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Score _$ScoreFromJson(Map<String, dynamic> json) {
  return Score()
    ..groupName = json['groupName'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$ScoreToJson(Score instance) => <String, dynamic>{
      'groupName': instance.groupName,
      'score': instance.score,
    };
