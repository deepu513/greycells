part of 'goals_bloc.dart';

abstract class GoalsState extends Equatable {
  const GoalsState();

  @override
  List<Object> get props => [];
}

class GoalsInitial extends GoalsState {}

class GoalsLoading extends GoalsState {}

class AllGoalsLoaded extends GoalsState {
  final List<Goal> goals;

  AllGoalsLoaded(this.goals);
}

class GoalCreated extends GoalsState {}

class GoalsError extends GoalsState {}

class DuplicateGoal extends GoalsState {}

class GoalsEmpty extends GoalsState {}

class GoalUpdated extends GoalsState {}

class GoalCompleted extends GoalsState {}
