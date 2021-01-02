part of 'task_bloc.dart';

abstract class TaskState {
  const TaskState();
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class AllTasksLoaded extends TaskState {
  final List<Task> tasks;
  final List<String> therapistNames;

  AllTasksLoaded(this.tasks, this.therapistNames);
}

class FilterApplied extends TaskState {
  final List<Task> tasks;
  final List<String> therapistNames;

  FilterApplied(this.tasks, this.therapistNames);
}

class TaskCreated extends TaskState {}

class TasksError extends TaskState {}

class TasksEmpty extends TaskState {}

class TaskUpdated extends TaskState {}

class TaskEdited extends TaskState {}
