import 'package:greycells/models/patient/patient_serializable.dart';
import 'package:greycells/networking/http_service.dart';

class PatientRepository {

  PatientSerializable _patientSerializable;
  HttpService _httpService;

  PatientRepository() {
    _httpService = HttpService();

    _patientSerializable = PatientSerializable();
  }
}