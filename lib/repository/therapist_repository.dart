import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/therapist/all_therapists.dart';
import 'package:greycells/models/therapist/all_therapists_serializable.dart';
import 'package:greycells/networking/http_service.dart';
import 'package:greycells/networking/request.dart';

class TherapistRepository {
  AllTherapistsSerializable _allTherapistSerializable;
  HttpService _httpService;

  TherapistRepository() {
    _httpService = HttpService();

    _allTherapistSerializable = AllTherapistsSerializable();
  }

  Future<AllTherapists> getTherapists(int pageNumber) async {
    Request<AllTherapists> request = Request(
        "${FlavorConfig.getBaseUrl()}Therapists/all?pageNo=$pageNumber", null);

    return await _httpService.get(request, _allTherapistSerializable);
  }
}
