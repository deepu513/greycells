part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadAllTasks extends TaskEvent {
  final UserType userType;

  LoadAllTasks(this.userType);
}

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
  final List<String> allNames;
  final String filterName;
  final UserType userType;

  ApplyFilter(this.existingTasks, this.filterName, this.allNames,
      {this.userType});
}

class UpdateTaskItem extends TaskEvent {
  final TaskItem taskItem;

  UpdateTaskItem(this.taskItem);
}
