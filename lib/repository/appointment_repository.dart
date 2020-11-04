import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/appointment/all_appointment_response.dart';
import 'package:greycells/models/appointment/all_appointment_serializable.dart';
import 'package:greycells/models/timeslot/timeslot_request.dart';
import 'package:greycells/models/timeslot/timeslot_request_serializable.dart';
import 'package:greycells/models/timeslot/timeslot_response.dart';
import 'package:greycells/models/timeslot/timeslot_response_serializable.dart';
import 'package:greycells/networking/http_service.dart';
import 'package:greycells/networking/request.dart';

class AppointmentRepository {
  HttpService _httpService;
  AllAppointmentResponseSerializable _allAppointmentResponseSerializable;
  TimeslotRequestSerializable _timeslotRequestSerializable;
  TimeslotResponseSerializable _timeslotResponseSerializable;

  AppointmentRepository() {
    this._httpService = HttpService();
    this._allAppointmentResponseSerializable =
        AllAppointmentResponseSerializable();
    this._timeslotRequestSerializable = TimeslotRequestSerializable();
    this._timeslotResponseSerializable = TimeslotResponseSerializable();
  }

  Future<AllAppointmentsResponse> getAllAppointments(
      int pageNumber, int appointmentStatus) async {
    Request<AllAppointmentsResponse> request = Request(
        "${FlavorConfig.getBaseUrl()}Appointments/all?pageno=$pageNumber&appoinmantstatus=$appointmentStatus",
        null);

    return await _httpService.get(request, _allAppointmentResponseSerializable);
  }

  Future<TimeslotResponse> getAvailableTimeslots(
      TimeslotRequest timeslotRequest) async {
    Request<TimeslotRequest> request = Request(
        "${FlavorConfig.getBaseUrl()}Appointments/timeslots",
        _timeslotRequestSerializable)
      ..setBody(timeslotRequest);

    return await _httpService.post(request, _timeslotResponseSerializable);
  }
}
