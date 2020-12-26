import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/models/goals/completed_goal.dart';
import 'package:greycells/models/goals/goal.dart';
import 'package:greycells/models/goals/update_goal_request.dart';
import 'package:greycells/networking/http_exceptions.dart';
import 'package:greycells/repository/goals_repository.dart';
import 'package:greycells/repository/settings_repository.dart';
import 'package:greycells/models/goals/create_goal_request.dart';

part 'goals_event.dart';
part 'goals_state.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  GoalsRepository _goalsRepository;
  SettingsRepository _settingsRepository;

  GoalsBloc() : super(GoalsInitial()) {
    _goalsRepository = GoalsRepository();
  }

  @override
  Stream<GoalsState> mapEventToState(
    GoalsEvent event,
  ) async* {
    if (event is LoadGoalsByPatient) {
      yield GoalsLoading();
      try {
        _settingsRepository = await SettingsRepository.getInstance();

        List<Goal> goals = await _goalsRepository.getGoalsByPatientId(
            event.patientId == null
                ? _settingsRepository.get(SettingKey.KEY_PATIENT_ID)
                : event.patientId);

        if (goals != null) {
          if (goals.isEmpty) {
            yield GoalsEmpty();
          } else if (goals.isNotEmpty) {
            yield AllGoalsLoaded(goals);
          }
        } else
          yield GoalsError();
      } catch (e) {
        debugPrint(e.toString());
        yield GoalsError();
      }
    }

    if (event is LoadCompletedGoals) {
      yield GoalsLoading();
      try {
        _settingsRepository = await SettingsRepository.getInstance();

        List<Goal> goals = await _goalsRepository.getGoalsByPatientId(
            _settingsRepository.get(SettingKey.KEY_PATIENT_ID));

        List<CompletedGoal> completedGoals =
            await _goalsRepository.getCompletedGoals(event.date);

        if (goals != null) {
          if (goals.isEmpty) {
            yield GoalsEmpty();
          } else if (goals.isNotEmpty) {
            List<int> completedGoalTypesId = List();

            completedGoals?.forEach((completedGoal) {
              completedGoalTypesId.add(completedGoal.goalId);
            });

            goals.forEach((aGoal) {
              aGoal.goalsTypes.forEach((goalType) {
                if (completedGoalTypesId.contains(goalType.id)) {
                  goalType.status = "Completed";
                } else
                  goalType.status = "InProgress";
              });
            });

            yield AllGoalsLoaded(goals);
          }
        } else
          yield GoalsError();
      } catch (e) {
        debugPrint(e.toString());
        yield GoalsError();
      }
    }

    if (event is UpdateGoal) {
      yield GoalsLoading();
      try {
        UpdateGoalRequest updateGoalRequest = UpdateGoalRequest()
          ..patientGoalMappingId = event.patientGoalMappingId
          ..patientId = _settingsRepository.get(SettingKey.KEY_PATIENT_ID)
          ..status = event.status;
        List<Goal> goals = await _goalsRepository.updateGoal(updateGoalRequest);
        if (goals != null) {
          if (goals.isEmpty) {
            yield GoalsEmpty();
          } else if (goals.isNotEmpty) {
            yield AllGoalsLoaded(goals);
          }
        } else
          yield GoalsError();
      } catch (e) {
        debugPrint(e.toString());
        yield GoalsError();
      }
    }

    if (event is CompleteGoal) {
      yield GoalsLoading();
      try {
        var result = await _goalsRepository.completeGoal(
            goalId: event.goalId, date: event.selectedDate);

        if (result != null && result == true) {
          add(LoadCompletedGoals(event.selectedDate));
        } else
          yield GoalsError();
      } catch (e) {
        debugPrint(e.toString());
        yield GoalsError();
      }
    }

    if (event is LoadGoalsMaster) {
      yield GoalsLoading();
      try {
        List<Goal> goals = await _goalsRepository.getGoalsMasterData();

        if (goals != null) {
          if (goals.isEmpty) {
            yield GoalsEmpty();
          } else if (goals.isNotEmpty) {
            yield AllGoalsLoaded(goals);
          }
        } else
          yield GoalsError();
      } catch (e) {
        debugPrint(e.toString());
        yield GoalsError();
      }
    }

    if (event is CreateGoal) {
      yield GoalsLoading();
      try {
        _settingsRepository = await SettingsRepository.getInstance();

        CreateGoalRequest createGoalRequest = CreateGoalRequest()
          ..goalTypeId = event.goalTypeId
          ..patientId = _settingsRepository.get(SettingKey.KEY_PATIENT_ID);

        List<Goal> goals = await _goalsRepository.createGoal(createGoalRequest);

        if (goals != null) {
          yield GoalCreated();
        } else
          yield GoalsError();
      } catch (e) {
        debugPrint(e.toString());
        if (e is BadRequestException) {
          yield DuplicateGoal();
        } else
          yield GoalsError();
      }
    }
  }
}
