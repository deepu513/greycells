import 'package:greycells/models/assessment/test_type.dart';
import 'package:greycells/networking/serializable.dart';

class TestTypeSerializable implements Serializable<TestType> {
  @override
  TestType fromJson(Map<String, dynamic> json) {
    return TestType.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(TestType testType) {
    return testType.toJson();
  }

  @override
  List<TestType> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray?.map((testTypeMap) =>
    testTypeMap == null ? null : fromJson(testTypeMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<TestType> testTypeList) {
    return testTypeList?.map((testType) => testType?.toJson())?.toList();
  }
}