import 'package:flutter/material.dart';
import 'package:greycells/bloc/task/task_status.dart';
import 'package:greycells/models/appointment/appointment_status.dart';

class TaskStatusWidget extends StatelessWidget {
  final TaskStatus taskStatus;

  TaskStatusWidget(this.taskStatus);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4.0),
        color: getBackgroundColorForStatus(taskStatus),
      ),
      child: Text(
        taskStatus.toString().split(".").last.toUpperCase(),
        style: Theme.of(context).textTheme.overline.copyWith(
              color: getTextColorForStatus(taskStatus),
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  Color getBackgroundColorForStatus(TaskStatus status) {
    if (status == TaskStatus.pending) {
      return Colors.blue.shade50;
    }

    if (status == TaskStatus.complete) {
      return Colors.green.shade50;
    }

    if (status == TaskStatus.overdue) {
      return Colors.pink.shade50;
    }

    return Colors.blue.shade50;
  }

  Color getTextColorForStatus(TaskStatus status) {
    if (status == TaskStatus.pending) {
      return Colors.blue.shade700;
    }

    if (status == TaskStatus.complete) {
      return Colors.green.shade700;
    }

    if (status == TaskStatus.overdue) {
      return Colors.pink.shade700;
    }

    return Colors.blue.shade700;
  }
}
