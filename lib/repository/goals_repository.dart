import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/goals/create_goal_req_serializable.dart';
import 'package:greycells/models/goals/goal.dart';
import 'package:greycells/models/goals/create_goal_request.dart';
import 'package:greycells/models/goals/goal_serializable.dart';
import 'package:greycells/models/goals/update_goal_req_serializable.dart';
import 'package:greycells/models/goals/update_goal_request.dart';
import 'package:greycells/networking/http_service.dart';
import 'package:greycells/networking/request.dart';

class GoalsRepository {
  HttpService _httpService;
  GoalSerializable _goalSerializable;
  CreateGoalRequestSerializable _createGoalRequestSerializable;
  UpdateGoalRequestSerializable _updateGoalRequestSerializable;

  GoalsRepository() {
    _httpService = HttpService();
    _goalSerializable = GoalSerializable();
    _createGoalRequestSerializable = CreateGoalRequestSerializable();
    _updateGoalRequestSerializable = UpdateGoalRequestSerializable();
  }

  Future<List<Goal>> getGoalsMasterData() async {
    Request<Goal> request =
        Request("${FlavorConfig.getBaseUrl()}Goals/Get", _goalSerializable);

    return await _httpService.getAll(request, _goalSerializable);
  }

  Future<List<Goal>> getGoalsByPatientId(int patiendId) async {
    Request<Goal> request = Request(
        "${FlavorConfig.getBaseUrl()}Goals/GetByPateintId?PatientId=$patiendId",
        _goalSerializable);

    return await _httpService.getAll(request, _goalSerializable);
  }

  Future<List<Goal>> createGoal(CreateGoalRequest createGoalRequest) async {
    Request<CreateGoalRequest> request = Request(
        "${FlavorConfig.getBaseUrl()}Goals/Post",
        _createGoalRequestSerializable);

    return await _httpService.postAll(request, _goalSerializable);
  }

  Future<List<Goal>> updateGoal(UpdateGoalRequest createGoalRequest) async {
    Request<UpdateGoalRequest> request = Request(
        "${FlavorConfig.getBaseUrl()}Goals/Put",
        _updateGoalRequestSerializable);

    return await _httpService.putAll(request, _goalSerializable);
  }
}
