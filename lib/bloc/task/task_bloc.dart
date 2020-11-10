import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greycells/models/task/task.dart';
import 'package:greycells/models/task/task_response.dart';
import 'package:greycells/repository/appointment_repository.dart';
import 'package:greycells/repository/file_repository.dart';
import 'package:greycells/extensions.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  FileRepository _fileRepository;
  AppointmentRepository _appointmentRepository;

  TaskBloc() : super(TaskInitial()) {
    _fileRepository = FileRepository();
    _appointmentRepository = AppointmentRepository();
  }

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is CreateTask) {
      yield TaskLoading();
      try {
        event.task.taskItems.forEach((item) async {
          if (!item.filePath.isNullOrEmpty()) {
            var serverFile = await _fileRepository.upload(item.filePath);
            if (serverFile != null) {
              item.fIleId = serverFile.fileId;
            }
          }
        });

        bool result = await _appointmentRepository.createTask(event.task);
        if (result == true) {
          yield TaskCreated();
        } else
          yield TasksError();
      } catch (e) {
        print(e);
        yield TasksError();
      }
    }

    if (event is LoadAllTasks) {
      yield TaskLoading();
      try {
        TaskResponse taskResponse = await _appointmentRepository.getTasks();
        if (taskResponse != null && taskResponse.tasks != null) {
          if (taskResponse.tasks.isEmpty)
            yield TasksEmpty();
          else
            yield AllTasksLoaded(taskResponse.tasks);
        } else
          TasksError();
      } catch (e) {
        print(e);
        yield TasksError();
      }
    }

    if (event is UpdateTask) {
      yield TaskLoading();
      try {
        bool result = await _appointmentRepository.updateTask(
            event.taskId, event.taskStatus);
        if (result == true) {
          yield TaskUpdated();
        } else
          TasksError();
      } catch (e) {
        print(e);
        yield TasksError();
      }
    }
  }
}
