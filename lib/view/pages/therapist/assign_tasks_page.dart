import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/task/task_bloc.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/task/assign_task_args.dart';
import 'package:greycells/models/task/task.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/task_item_widget.dart';
import 'package:provider/provider.dart';
import 'package:greycells/extensions.dart';

class AssignTasksPage extends StatefulWidget {
  final AssignTaskArgs args;

  const AssignTasksPage({Key key, @required this.args}) : super(key: key);

  @override
  _AssignTasksPageState createState() => _AssignTasksPageState();
}

class _AssignTasksPageState extends State<AssignTasksPage> {
  Task task;
  bool titleIsEmpty;

  @override
  void initState() {
    super.initState();
    task = Task()
      ..therapistId = widget.args.therapistId
      ..patientId = widget.args.patientId
      ..appointmentId = widget.args.appointmentId;
    task.taskItems = List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          'Assign Tasks',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: Provider<Task>.value(
          value: task,
          child: BlocConsumer<TaskBloc, TaskState>(
            listener: (context, state) async {
              if (state is TaskCreated) {
                await widget.showSuccessDialog(
                  context: context,
                  message: "Task created and assigned successfully!",
                  showIcon: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  });
                  Navigator.of(context).pop();
              }

              if (state is TasksError) {
                widget.showErrorDialog(
                    context: context,
                    message: ErrorMessages.GENERIC_ERROR_MESSAGE,
                    showIcon: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                    });
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: TaskTitleInput(
                      showError: titleIsEmpty == true,
                      onTitleChanged: (title) {
                        task.title = title;
                      },
                    ),
                  ),
                  Divider(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    child: TaskSubSection(
                      onAddPressed: state is! TaskLoading
                          ? () async {
                              var taskItem = await Navigator.of(context)
                                  .pushNamed(RouteName.ADD_TASK_ITEM_PAGE);
                              if (taskItem != null) {
                                setState(() => task.taskItems.add(taskItem));
                              }
                            }
                          : null,
                    ),
                  ),
                  Divider(
                    height: 8.0,
                  ),
                  Expanded(
                    child: task.taskItems.isNotEmpty
                        ? TaskItemsListSection()
                        : EmptyState(
                            svgImageName: "to_do_list.svg",
                            title: "Assign tasks to your client!",
                            description:
                                "Click on 'ADD ITEM' to add a task item.",
                          ),
                  ),
                  Visibility(
                      visible: state is TaskLoading,
                      child: LinearProgressIndicator(
                        minHeight: 2.0,
                        backgroundColor: Colors.white,
                      )),
                  TaskCreateAssignButton(
                    onPressed:
                        task.taskItems.isNotEmpty && state is! TaskLoading
                            ? () {
                                if (task.title.isNullOrEmpty()) {
                                  setState(() {
                                    titleIsEmpty = true;
                                  });
                                } else {
                                  BlocProvider.of<TaskBloc>(context)
                                      .add(CreateTask(task));
                                }
                              }
                            : null,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class TaskTitleInput extends StatelessWidget {
  final bool showError;
  final ValueChanged<String> onTitleChanged;

  const TaskTitleInput(
      {Key key, @required this.showError, @required this.onTitleChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      textInputAction: TextInputAction.done,
      style: Theme.of(context)
          .textTheme
          .headline5
          .copyWith(fontWeight: FontWeight.w700),
      decoration: InputDecoration(
        border: InputBorder.none,
        helperText: Strings.tapToEnter,
        hintText: Strings.title + "*",
        hintStyle: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Colors.black38, fontWeight: FontWeight.w700),
        contentPadding: EdgeInsets.zero,
        errorText: showError ? ErrorMessages.EMPTY_FIELD_ERROR_MESSAGE : null,
      ),
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      onChanged: onTitleChanged,
      onEditingComplete: () => FocusScope.of(context).unfocus(),
    );
  }
}

class TaskSubSection extends StatelessWidget {
  final VoidCallback onAddPressed;

  const TaskSubSection({Key key, @required this.onAddPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TasksCountSection(),
        Spacer(),
        TaskAddButton(
          onPressed: onAddPressed,
        )
      ],
    );
  }
}

class TasksCountSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: Provider.of<Task>(context, listen: false)
            .taskItems
            .length
            .toString(),
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: " tasks added",
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.black38),
          ),
        ],
      ),
    );
  }
}

class TaskAddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TaskAddButton({Key key, @required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      icon: Icon(
        Icons.add_rounded,
        color: Colors.white,
        size: 20.0,
      ),
      onPressed: onPressed,
      color: Color(0xFF455a64),
      splashColor: Colors.white24,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      disabledColor: Colors.grey.shade400,
      label: Text(
        "ADD ITEM",
        style: Theme.of(context).textTheme.button.copyWith(
              wordSpacing: 1.0,
              letterSpacing: 0.75,
              color: Colors.white,
            ),
      ),
    );
  }
}

class TaskCreateAssignButton extends StatelessWidget {
  final VoidCallback onPressed;
  TaskCreateAssignButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      disabledColor: Colors.grey.shade400,
      height: 56.0,
      minWidth: double.maxFinite,
      child: Text(
        "Create and assign".toUpperCase(),
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              wordSpacing: 1.0,
              letterSpacing: 0.75,
              color: Colors.white,
            ),
      ),
    );
  }
}

class TaskItemsListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var taskItems = Provider.of<Task>(context).taskItems;
    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        return TaskItemWidget(
          taskItem: taskItems[index],
        );
      },
      itemCount: taskItems.length,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 8.0,
        );
      },
    );
  }
}
