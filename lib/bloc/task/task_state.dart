part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TasksLoaded extends TaskState {}

class TasksError extends TaskState {}

class TasksEmpty extends TaskState {}

class TaskUpdated extends TaskState {}
