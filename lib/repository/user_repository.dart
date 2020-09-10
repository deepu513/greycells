import 'package:flutter/foundation.dart';
import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/login/login_request.dart';
import 'package:greycells/models/login/login_request_serializable.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/models/patient/patient_serializable.dart';
import 'package:greycells/models/registration/registration.dart';
import 'package:greycells/models/registration/registration_serializable.dart';
import 'package:greycells/models/user/user.dart';
import 'package:greycells/models/user/user_serializable.dart';
import 'package:greycells/networking/http_service.dart';
import 'package:greycells/networking/request.dart';
import 'package:greycells/networking/response.dart';

class UserRepository {
  RegistrationSerializable _registrationSerializable;
  LoginRequestSerializable _loginRequestSerializable;
  PatientSerializable _patientSerializable;
  UserSerializable _userSerializable;

  HttpService _httpService;

  UserRepository() {
    _httpService = HttpService();
    _registrationSerializable = RegistrationSerializable();
    _loginRequestSerializable = LoginRequestSerializable();
    _patientSerializable = PatientSerializable();
    _userSerializable = UserSerializable();
  }

  Future<bool> register({@required Registration registration}) async {
    Request<Registration> request = Request(
        "${FlavorConfig.getBaseUrl()}Account/register",
        _registrationSerializable)
      ..setBody(registration);

    Response loginResponse = await _httpService.postRaw(request, null);
    return loginResponse.statusCode == 200;
  }

  Future<User> authenticate({@required LoginRequest loginRequest}) async {
    Request<LoginRequest> request = Request(
        "${FlavorConfig.getBaseUrl()}Account/authenticate",
        _loginRequestSerializable)
      ..setBody(loginRequest);

    return await _httpService.post(request, _userSerializable);
  }

  savePatientDetails({@required Patient patient}) async {
    Request<Patient> request = Request(
        "${FlavorConfig.getBaseUrl()}Patient/CreatePatient",
        _patientSerializable)..setBody(patient);

    return await _httpService.post(request, responseSerializable);
  }
}
