part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadAllTasks extends TaskEvent {}

class CreateTask extends TaskEvent {
  final Task task;

  CreateTask(this.task);
}

class LoadPatientTasks extends TaskEvent {
  final int patientId;
  LoadPatientTasks(this.patientId);
}

class UpdateTaskItem extends TaskEvent {
  final TaskItem taskItem;

  UpdateTaskItem(this.taskItem);
}
