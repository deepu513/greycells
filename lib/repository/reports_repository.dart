import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/reports/report.dart';
import 'package:greycells/models/reports/report_serializable.dart';
import 'package:greycells/networking/http_service.dart';
import 'package:greycells/networking/request.dart';

class ReportsRepository {
  HttpService _httpService;
  ReportSerializable _reportSerializable;
  ReportsRepository() {
    _httpService = HttpService();
    _reportSerializable = ReportSerializable();
  }

  Future<List<Report>> getReportsForPatient(int patiendId) async {
    Request<Report> request = Request(
        "${FlavorConfig.getBaseUrl()}Patient/reports?id=$patiendId",
        _reportSerializable);

    return await _httpService.getAll(request, _reportSerializable);
  }
}
