part of 'goals_bloc.dart';

abstract class GoalsEvent extends Equatable {
  const GoalsEvent();

  @override
  List<Object> get props => [];
}

class LoadGoalsMaster extends GoalsEvent {}

class LoadGoalsByPatient extends GoalsEvent {
  final int patientId;
  LoadGoalsByPatient({this.patientId});
}

class CreateGoal extends GoalsEvent {
  final int goalTypeId;

  CreateGoal({@required this.goalTypeId});
}

class UpdateGoal extends GoalsEvent {
  final int status;
  final int patientGoalMappingId;

  UpdateGoal({@required this.status, @required this.patientGoalMappingId});
}

class LoadCompletedGoals extends GoalsEvent {
  final String date;

  LoadCompletedGoals(this.date);
}

class CompleteGoal extends GoalsEvent {
  final int goalId;
  final String selectedDate;

  CompleteGoal(this.goalId, this.selectedDate);
}
