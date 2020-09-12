import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/assessment/test.dart';
import 'package:greycells/models/assessment/test_serializable.dart';
import 'package:greycells/models/assessment/test_type.dart';
import 'package:greycells/models/assessment/test_type_serializable.dart';
import 'package:greycells/networking/http_service.dart';
import 'package:greycells/networking/request.dart';

class AssessmentTestRepository {
  HttpService _httpService;
  TestTypeSerializable _testTypeSerializable;
  TestSerializable _testSerializable;

  AssessmentTestRepository() {
    _httpService = HttpService();
    _testTypeSerializable = TestTypeSerializable();
    _testSerializable = TestSerializable();
  }

  Future<Test> getTest() async {
    Request<Test> request = Request(
        "${FlavorConfig.getBaseUrl()}Assessment/TestTypes", null);

    return await _httpService.get(request, _testSerializable);
  }
}
