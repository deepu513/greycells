import 'package:flutter/foundation.dart';
import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/home/patient_home.dart';
import 'package:greycells/models/home/patient_home_serializable.dart';
import 'package:greycells/models/home/therapist_home.dart';
import 'package:greycells/models/home/therapist_home_serializable.dart';
import 'package:greycells/models/login/login_request.dart';
import 'package:greycells/models/login/login_request_serializable.dart';
import 'package:greycells/models/patient/create_patient_response.dart';
import 'package:greycells/models/patient/create_patient_serializable.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/models/patient/patient_serializable.dart';
import 'package:greycells/models/patient/update_patient_request.dart';
import 'package:greycells/models/patient/update_patient_request_serializable.dart';
import 'package:greycells/models/registration/registration.dart';
import 'package:greycells/models/registration/registration_serializable.dart';
import 'package:greycells/models/token/token.dart';
import 'package:greycells/models/token/token_serializable.dart';
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
  UpdatePatientRequestSerializable _updatePatientRequestSerializable;
  HomeSerializable _homeSerializable;
  TherapistHomeSerializable _therapistHomeSerializable;

  HttpService _httpService;

  UserRepository() {
    _httpService = HttpService();
    _registrationSerializable = RegistrationSerializable();
    _loginRequestSerializable = LoginRequestSerializable();
    _patientSerializable = PatientSerializable();
    _createPatientResponseSerializable = CreatePatientResponseSerializable();
    _updatePatientRequestSerializable = UpdatePatientRequestSerializable();
    _userSerializable = UserSerializable();
    _homeSerializable = HomeSerializable();
    _therapistHomeSerializable = TherapistHomeSerializable();
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

  Future<PatientHome> getPatientHomeData() async {
    Request<PatientHome> request =
        Request("${FlavorConfig.getBaseUrl()}Account/patienthome", null);

    return await _httpService.get(request, _homeSerializable);
  }

  Future<int> resetPassword({@required String email}) async {
    Request request = Request(
        "${FlavorConfig.getBaseUrl()}Account/ForgotPassword?email=$email",
        null);

    Response response = await _httpService.postRaw(request, null);
    return response.statusCode;
  }

  Future<TherapistHome> getTherapistHomeData() async {
    Request<PatientHome> request =
        Request("${FlavorConfig.getBaseUrl()}Account/therapisthome", null);

    return await _httpService.get(request, _therapistHomeSerializable);
  }

  Future<bool> updateToken({@required Token token}) async {
    Request<Token> request = Request(
      "${FlavorConfig.getBaseUrl()}Customer/UpdateToken",
      TokenSerializable(),
    )..setBody(token);

    Response updateResponse = await _httpService.putRaw(request, null);
    return updateResponse.statusCode == 200;
  }

  Future<List<Patient>> getAllPatients() async {
    Request<Patient> request = Request(
        "${FlavorConfig.getBaseUrl()}patient/all", _patientSerializable);

    return await _httpService.getAll(request, _patientSerializable);
  }

  Future<bool> markEligibleForTest({@required int patientId}) async {
    Request request = Request(
        "${FlavorConfig.getBaseUrl()}patient/eligibleforassessment?id=$patientId",
        null);

    Response response = await _httpService.getRaw(request, null);
    return response.statusCode == 200;
  }

  Future<Patient> updatePatientDetails(
      {@required UpdatePatientRequest updatePatientRequest}) async {
    Request<UpdatePatientRequest> request = Request(
        "${FlavorConfig.getBaseUrl()}Patient/profile",
        _updatePatientRequestSerializable)
      ..setBody(updatePatientRequest);

    return await _httpService.post(request, _patientSerializable);
  }

  Future<bool> isEligibleForFollowup(
      {@required int therapistId, @required int meetingTypeId}) async {
    Request request = Request(
        "${FlavorConfig.getBaseUrl()}Appointments/Iseligibleforfollowup?therapistId=$therapistId&meetingTypeid=$meetingTypeId",
        null);

    Response response = await _httpService.getRaw(request, null);
    return response.statusCode == 200;
  }
}
