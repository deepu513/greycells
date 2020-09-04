import 'package:flutter/foundation.dart';
import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/login/login_request.dart';
import 'package:greycells/models/login/login_request_serializable.dart';
import 'package:greycells/models/registration/registration.dart';
import 'package:greycells/models/registration/registration_serializable.dart';
import 'package:greycells/networking/http_service.dart';
import 'package:greycells/networking/method.dart';
import 'package:greycells/networking/request.dart';
import 'package:greycells/networking/response.dart';

class UserRepository {
  var _userSerializable;
  RegistrationSerializable _registrationSerializable;

  HttpService _httpService;

  UserRepository() {
    _httpService = HttpService.instance;
    _registrationSerializable = RegistrationSerializable();
  }

  Future<bool> register({@required Registration registration}) async {
    Request<Registration> request = Request(
        Method.POST, "${FlavorConfig.getBaseUrl()}Account/register",
        _registrationSerializable)..setBody(registration);

    Response loginResponse = await _httpService.enqueue(request, null);
    return loginResponse.statusCode == 200;
  }
}
