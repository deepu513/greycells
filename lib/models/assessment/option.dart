import 'package:json_annotation/json_annotation.dart';

part 'option.g.dart';

@JsonSerializable(explicitToJson: true)
class Option {
  @JsonKey(name: "text")
  String optionText;

  int questionId;
  int score;
  int id;

  bool isActive;

  Option();

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

    Map<String, dynamic> toJson() => _$OptionToJson(this);
}
