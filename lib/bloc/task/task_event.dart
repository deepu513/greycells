part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadAllTasks extends TaskEvent {}

class CreateTask extends TaskEvent {}

class UpdateTask extends TaskEvent {}
