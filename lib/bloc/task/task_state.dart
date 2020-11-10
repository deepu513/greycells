part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class AllTasksLoaded extends TaskState {
  final List<Task> tasks;

  AllTasksLoaded(this.tasks);
}

class TaskCreated extends TaskState {}

class TasksError extends TaskState {}

class TasksEmpty extends TaskState {}

class TaskUpdated extends TaskState {}
