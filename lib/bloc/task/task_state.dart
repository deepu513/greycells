part of 'task_bloc.dart';

abstract class TaskState {
  const TaskState();
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class AllTasksLoaded extends TaskState {
  final List<Task> tasks;
  final List<String> therapistNames;
  final List<String> patientNames;

  AllTasksLoaded(this.tasks, {this.therapistNames, this.patientNames});
}

class FilterApplied extends TaskState {
  final List<Task> tasks;
  final List<String> filteredNames;

  FilterApplied(this.tasks, this.filteredNames);
}

class TaskCreated extends TaskState {}

class TasksError extends TaskState {}

class TasksEmpty extends TaskState {}

class TaskUpdated extends TaskState {}

class TaskEdited extends TaskState {}
