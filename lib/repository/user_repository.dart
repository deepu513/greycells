import 'package:flutter/foundation.dart';
import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/home/home.dart';
import 'package:greycells/models/home/home_serializable.dart';
import 'package:greycells/models/login/login_request.dart';
import 'package:greycells/models/login/login_request_serializable.dart';
import 'package:greycells/models/patient/create_patient_response.dart';
import 'package:greycells/models/patient/create_patient_serializable.dart';
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
  CreatePatientResponseSerializable _createPatientResponseSerializable;
  HomeSerializable _homeSerializable;

  HttpService _httpService;

  UserRepository() {
    _httpService = HttpService();
    _registrationSerializable = RegistrationSerializable();
    _loginRequestSerializable = LoginRequestSerializable();
    _patientSerializable = PatientSerializable();
    _createPatientResponseSerializable = CreatePatientResponseSerializable();
    _userSerializable = UserSerializable();
    _homeSerializable = HomeSerializable();
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

  Future<CreatePatientResponse> savePatientDetails(
      {@required Patient patient}) async {
    Request<Patient> request = Request(
        "${FlavorConfig.getBaseUrl()}Patient/CreatePatient",
        _patientSerializable)
      ..setBody(patient);

    return await _httpService.post(request, _createPatientResponseSerializable);
  }

  Future<Home> getHomeData() async {
    Request<Home> request =
        Request("${FlavorConfig.getBaseUrl()}Account/home", null);

    return await _httpService.get(request, _homeSerializable);
  }

  Future<int> resetPassword({@required String email}) async {
    Request request = Request(
        "${FlavorConfig.getBaseUrl()}Account/ForgotPassword?email=$email",
        null);

    Response response = await _httpService.postRaw(request, null);
    return response.statusCode;
  }
}
