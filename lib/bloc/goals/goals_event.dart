part of 'goals_bloc.dart';

abstract class GoalsEvent extends Equatable {
  const GoalsEvent();

  @override
  List<Object> get props => [];
}

class LoadGoalsMaster extends GoalsEvent {}

class LoadGoalsByPatient extends GoalsEvent {}

class CreateGoal extends GoalsEvent {
  final int goalTypeId;

  CreateGoal({@required this.goalTypeId});
}

class UpdateGoal extends GoalsEvent {
  final int status;
  final int patientGoalMappingId;

  UpdateGoal({@required this.status, @required this.patientGoalMappingId});
}
