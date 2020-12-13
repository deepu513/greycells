import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/therapist/all_therapists.dart';
import 'package:greycells/models/therapist/all_therapists_serializable.dart';
import 'package:greycells/models/therapist/therapist_type.dart';
import 'package:greycells/models/therapist/therapist_type_serializable.dart';
import 'package:greycells/networking/http_service.dart';
import 'package:greycells/networking/request.dart';
import 'package:greycells/models/therapist/therapist_type_response.dart';

class TherapistRepository {
  AllTherapistsSerializable _allTherapistSerializable;
  TherapistTypeResponseSerializable _therapistTypeSerializable;
  HttpService _httpService;

  TherapistRepository() {
    _httpService = HttpService();

    _allTherapistSerializable = AllTherapistsSerializable();
    _therapistTypeSerializable = TherapistTypeResponseSerializable();
  }

  Future<AllTherapists> getTherapists(int pageNumber) async {
    Request<AllTherapists> request = Request(
        "${FlavorConfig.getBaseUrl()}Therapists/all?pageNo=$pageNumber", null);

    return await _httpService.get(request, _allTherapistSerializable);
  }

  Future<AllTherapists> getTherapistsWithType(
      TherapistType therapistType) async {
    Request<AllTherapists> request = Request(
        "${FlavorConfig.getBaseUrl()}Therapists/all?pageNo=1&therapytype=${therapistType.id}",
        null);

    return await _httpService.get(request, _allTherapistSerializable);
  }

  Future<TherapistTypeResponse> getTherapistTypes() async {
    Request<TherapistTypeResponse> request = Request(
        "${FlavorConfig.getBaseUrl()}Therapists/therapytype",
        _therapistTypeSerializable);

    return await _httpService.get(request, _therapistTypeSerializable);
  }
}
