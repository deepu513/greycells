import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:greycells/bloc/task/task_status.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/task/task.dart';
import 'package:greycells/models/task/task_item.dart';
import 'package:greycells/models/task/task_response.dart';
import 'package:greycells/repository/appointment_repository.dart';
import 'package:greycells/repository/file_repository.dart';
import 'package:greycells/extensions.dart';
import 'package:intl/intl.dart';

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
        bool result = await _appointmentRepository.createTask(event.task);
        if (result == true) {
          yield TaskCreated();
        } else
          yield TasksError();
      } catch (e) {
        debugPrint(e.toString());
        yield TasksError();
      }
    }

    if (event is UpdateTask) {
      yield TaskLoading();
      try {
        bool result = await _appointmentRepository.editTask(event.task);
        if (result == true) {
          yield TaskEdited();
        } else
          yield TasksError();
      } catch (e) {
        debugPrint(e.toString());
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
          else {
            if (event.userType == UserType.therapist) {
              List<String> therapistNames = List();
              therapistNames.add("All");

              taskResponse.tasks.forEach((task) {
                if (task.therapist != null)
                  therapistNames.add(task.therapist.fullName);

                task.taskItems.forEach((taskItem) {
                  if (taskItem.status == 0) {
                    DateFormat dateFormat = DateFormat("dd/MM/yyyy h:mm:ss a");
                    DateTime dateTime =
                        dateFormat.parse(taskItem.expectedCompletionDateTIme);
                    if (DateTime.now().isBefore(dateTime) == false) {
                      taskItem.status = TaskStatus.overdue.index;
                    }
                  }
                });
              });

              yield AllTasksLoaded(taskResponse.tasks,
                  therapistNames: therapistNames.toSet().toList());
            } else {
              List<String> patientNames = List();
              patientNames.add("All");

              taskResponse.tasks.forEach((task) {
                if (task.patient != null)
                  patientNames.add(task.patient.fullName);

                task.taskItems.forEach((taskItem) {
                  if (taskItem.status == 0) {
                    DateFormat dateFormat = DateFormat("dd/MM/yyyy h:mm:ss a");
                    DateTime dateTime =
                        dateFormat.parse(taskItem.expectedCompletionDateTIme);
                    if (DateTime.now().isBefore(dateTime) == false) {
                      taskItem.status = TaskStatus.overdue.index;
                    }
                  }
                });
              });

              yield AllTasksLoaded(taskResponse.tasks,
                  patientNames: patientNames.toSet().toList());
            }
          }
        } else
          yield TasksError();
      } catch (e) {
        debugPrint(e.toString());
        yield TasksError();
      }
    }

    if (event is ApplyFilter) {
      List<Task> filteredTasks = List();
      if (event.userType == UserType.therapist) {
        if (event.filterName == "All") {
          yield FilterApplied(event.existingTasks, event.allNames);
        } else {
          event.existingTasks.forEach((task) {
            if (task.therapist.fullName == event.filterName) {
              filteredTasks.add(task);
            }
          });
          yield FilterApplied(filteredTasks, event.allNames);
        }
      } else if (event.userType == UserType.patient) {
        if (event.filterName == "All") {
          yield FilterApplied(event.existingTasks, event.allNames);
        } else {
          event.existingTasks.forEach((task) {
            if (task.patient.fullName == event.filterName) {
              filteredTasks.add(task);
            }
          });
          yield FilterApplied(filteredTasks, event.allNames);
        }
      }
    }

    if (event is UpdateTaskItem) {
      yield TaskLoading();
      try {
        if (!event.taskItem.filePath.isNullOrEmpty()) {
          var serverFile =
              await _fileRepository.upload(event.taskItem.filePath);
          if (serverFile != null) {
            event.taskItem.fIleId = serverFile.fileId;
          }
        }

        bool result = await _appointmentRepository.updateTask(
            event.taskItem.id, 1, event.taskItem.fIleId);
        if (result == true) {
          yield TaskUpdated();
        } else
          yield TasksError();
      } catch (e) {
        debugPrint(e.toString());
        yield TasksError();
      }
    }

    if (event is LoadPatientTasks) {
      yield TaskLoading();
      try {
        List<Task> tasks = await _appointmentRepository.getTaskByPatientId(
            event.patientId,
            event.forTherapist ?? false,
            event.therapistId ?? 0);
        if (tasks != null) {
          if (tasks.isEmpty)
            yield TasksEmpty();
          else {
            yield AllTasksLoaded(tasks);
          }
        } else
          yield TasksError();
      } catch (e) {
        debugPrint(e.toString());
        yield TasksError();
      }
    }
  }
}
