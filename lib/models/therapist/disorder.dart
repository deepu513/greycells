import 'package:json_annotation/json_annotation.dart';

part 'disorder.g.dart';

@JsonSerializable(explicitToJson: true)
class Disorder {
  String name;
  int duration;
  int id;

  Disorder();

  factory Disorder.fromJson(Map<String, dynamic> json) =>
      _$DisorderFromJson(json);
  Map<String, dynamic> toJson() => _$DisorderToJson(this);
}
