import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/task/task_item.dart';

class TaskItemPageArgs {
  final TaskItem taskItem;
  final UserType userType;

  TaskItemPageArgs(this.taskItem, this.userType);
}
