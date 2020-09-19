import 'package:greycells/models/assessment/score.dart';
import 'package:greycells/networking/serializable.dart';

class ScoreSerializable implements Serializable<Score> {
  @override
  Score fromJson(Map<String, dynamic> json) {
    return Score.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Score score) {
    return score.toJson();
  }

  @override
  List<Score> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray?.map((scoreMap) =>
    scoreMap == null ? null : fromJson(scoreMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<Score> scoreList) {
    return scoreList?.map((score) => score?.toJson())?.toList();
  }
}