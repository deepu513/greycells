import 'package:json_annotation/json_annotation.dart';

part 'test_type.g.dart';

@JsonSerializable(explicitToJson: true)
class TestType {
  int id;
  String name;
  bool isActive;

  TestType();

  factory TestType.fromJson(Map<String, dynamic> json) =>
      _$TestTypeFromJson(json);

  Map<String, dynamic> toJson() => _$TestTypeToJson(this);
}
