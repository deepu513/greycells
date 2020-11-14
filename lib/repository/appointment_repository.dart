import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/appointment/all_appointment_response.dart';
import 'package:greycells/models/appointment/all_appointment_serializable.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/models/appointment/create_appointment_request.dart';
import 'package:greycells/models/appointment/create_appointment_request_serializable.dart';
import 'package:greycells/models/task/task.dart';
import 'package:greycells/models/task/task_response.dart';
import 'package:greycells/models/task/task_response_serializable.dart';
import 'package:greycells/models/task/task_serializable.dart';
import 'package:greycells/models/timeslot/timeslot_request.dart';
import 'package:greycells/models/timeslot/timeslot_request_serializable.dart';
import 'package:greycells/models/timeslot/timeslot_response.dart';
import 'package:greycells/models/timeslot/timeslot_response_serializable.dart';
import 'package:greycells/networking/http_service.dart';
import 'package:greycells/networking/request.dart';
import 'package:greycells/networking/response.dart';

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

  Future<bool> updateAppointment(
      int appointmentId, AppointmentStatus status) async {
    Request<CreateAppointmentRequest> request = Request(
        "${FlavorConfig.getBaseUrl()}Appointments/update?id=$appointmentId&status=${status.index}",
        null)
      ..setBody(null);

    Response updateAppointmentResponse = await _httpService.getRaw(request, null);
    return updateAppointmentResponse.statusCode == 200;
  }

  Future<bool> createAppointment(
      CreateAppointmentRequest createAppointmentRequest) async {
    Request<CreateAppointmentRequest> request = Request(
        "${FlavorConfig.getBaseUrl()}Appointments/CreateAppoinment",
        CreateAppointmentRequestSerializable())
      ..setBody(createAppointmentRequest);

    Response createAppointmentResponse =
        await _httpService.postRaw(request, null);
    return createAppointmentResponse.statusCode == 200;
  }

  Future<bool> createTask(Task task) async {
    Request<Task> request =
        Request("${FlavorConfig.getBaseUrl()}Tasks", TaskSerializable())
          ..setBody(task);

    Response createTaskResponse = await _httpService.postRaw(request, null);
    return createTaskResponse.statusCode == 200;
  }

  Future<TaskResponse> getTasks() async {
    Request<TaskResponse> request =
        Request("${FlavorConfig.getBaseUrl()}Tasks", null)..setBody(null);

    return await _httpService.get(request, TaskResponseSerializable());
  }

  Future<bool> updateTask(int taskId, int taskStatus, int fileId) async {
    Request<AllAppointmentsResponse> request = Request(
        "${FlavorConfig.getBaseUrl()}Tasks/update?id=$taskId&status=$taskStatus&fileid=$fileId",
        null);

    Response response = await _httpService.postRaw(request, null);
    return response.statusCode == 200;
  }
}
