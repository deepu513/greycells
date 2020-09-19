import 'package:flutter/foundation.dart';
import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/assessment/save_option_serializable.dart';
import 'package:greycells/models/assessment/test.dart';
import 'package:greycells/models/assessment/test_serializable.dart';
import 'package:greycells/networking/http_service.dart';
import 'package:greycells/networking/request.dart';
import 'package:greycells/models/assessment/save_option_request.dart';
import 'package:greycells/networking/response.dart';

class AssessmentTestRepository {
  HttpService _httpService;
  TestSerializable _testSerializable;
  SaveOptionRequestSerializable _optionRequestSerializable;

  AssessmentTestRepository() {
    _httpService = HttpService();
    _testSerializable = TestSerializable();
    _optionRequestSerializable = SaveOptionRequestSerializable();
  }

  Future<Test> getTest(int testId) async {
    Request<Test> request = Request(
        "${FlavorConfig.getBaseUrl()}Assessment/Questions/$testId", null);

    return await _httpService.get(request, _testSerializable);
  }

  Future<bool> saveOption({@required SaveOptionRequest saveOptionRequest}) async {
    Request<SaveOptionRequest> request = Request(
        "${FlavorConfig.getBaseUrl()}Assessment",
        _optionRequestSerializable)
      ..setBody(saveOptionRequest);

    Response optionSavedResponse = await _httpService.postRaw(request, null);
    return optionSavedResponse.statusCode == 200;
  }
}
