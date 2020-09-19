import 'package:json_annotation/json_annotation.dart';

part 'score.g.dart';

@JsonSerializable(explicitToJson: true)
class Score {
  String groupName;
  int score;

  Score();

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreToJson(this);
}
