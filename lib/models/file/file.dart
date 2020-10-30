import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@JsonSerializable(explicitToJson: true)
class File {
  String type;

  @JsonKey(name: "url")
  String name;
  
  int id;

  File();

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);
  Map<String, dynamic> toJson() => _$FileToJson(this);
}
