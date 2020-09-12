import 'package:greycells/models/assessment/test.dart';
import 'package:greycells/networking/serializable.dart';

class TestSerializable implements Serializable<Test> {
  @override
  Test fromJson(Map<String, dynamic> json) {
    return Test.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Test test) {
    return test.toJson();
  }

  @override
  List<Test> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray?.map((testMap) =>
    testMap == null ? null : fromJson(testMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<Test> testList) {
    return testList?.map((test) => test?.toJson())?.toList();
  }
}