import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/appointment/all_appointment_response.dart';
import 'package:greycells/models/appointment/all_appointment_serializable.dart';
import 'package:greycells/networking/http_service.dart';
import 'package:greycells/networking/request.dart';

class AppointmentRepository {
  HttpService _httpService;
  AllAppointmentResponseSerializable _allAppointmentResponseSerializable;

  AppointmentRepository() {
    this._httpService = HttpService();
    this._allAppointmentResponseSerializable =
        AllAppointmentResponseSerializable();
  }

  Future<AllAppointmentsResponse> getAllAppointments(
      int pageNumber, int appointmentStatus) async {
    Request<AllAppointmentsResponse> request = Request(
        "${FlavorConfig.getBaseUrl()}Appointments/all?pageno=$pageNumber&appoinmantstatus=$appointmentStatus",
        null);

    return await _httpService.get(request, _allAppointmentResponseSerializable);
  }
}
