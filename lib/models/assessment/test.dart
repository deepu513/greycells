import 'package:greycells/models/assessment/question.dart';
import 'package:greycells/models/assessment/test_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test.g.dart';

@JsonSerializable(explicitToJson: true)
class Test {
  TestType testType;
  List<Question> questions;

  Test();

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);

  Map<String, dynamic> toJson() => _$TestToJson(this);
}
