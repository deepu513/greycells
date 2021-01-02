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

class UpdateTask extends TaskEvent {
  final Task task;
  UpdateTask(this.task);
}

class LoadPatientTasks extends TaskEvent {
  final int patientId;
  final bool forTherapist;
  final int therapistId;

  LoadPatientTasks(this.patientId, {this.forTherapist, this.therapistId});
}

class ApplyFilter extends TaskEvent {
  final List<Task> existingTasks;
  final List<String> allTherapistNames;
  final String therapistName;

  ApplyFilter(this.existingTasks, this.therapistName, this.allTherapistNames);
}

class UpdateTaskItem extends TaskEvent {
  final TaskItem taskItem;

  UpdateTaskItem(this.taskItem);
}
