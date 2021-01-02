import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/task/task_bloc.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/task/task.dart';
import 'package:greycells/models/task/task_item.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/task_item_widget.dart';
import 'package:provider/provider.dart';
import 'package:greycells/extensions.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({Key key, @required this.task}) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  bool titleIsEmpty;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          'Edit Task',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: Provider<Task>.value(
          value: widget.task,
          child: BlocConsumer<TaskBloc, TaskState>(
            listener: (context, state) async {
              if (state is TaskEdited) {
                await widget.showSuccessDialog(
                    context: context,
                    message: "Task edited successfully!",
                    showIcon: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                    });
                Navigator.of(context).pop(true);
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
                        widget.task.title = title;
                      },
                    ),
                  ),
                  Divider(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: TasksCountSection(),
                  ),
                  Divider(
                    height: 8.0,
                  ),
                  Expanded(
                    child: widget.task.taskItems.isNotEmpty
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
                  TaskUpdateButton(
                    onPressed: widget.task.taskItems.isNotEmpty &&
                            state is! TaskLoading
                        ? () {
                            if (widget.task.title.isNullOrEmpty()) {
                              setState(() {
                                titleIsEmpty = true;
                              });
                            } else {
                              BlocProvider.of<TaskBloc>(context)
                                  .add(UpdateTask(widget.task));
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
      controller: TextEditingController(
          text: Provider.of<Task>(context, listen: false).title ?? ""),
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

class TaskUpdateButton extends StatelessWidget {
  final VoidCallback onPressed;
  TaskUpdateButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      disabledColor: Colors.grey.shade400,
      height: 56.0,
      minWidth: double.maxFinite,
      child: Text(
        "Update Task".toUpperCase(),
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              wordSpacing: 1.0,
              letterSpacing: 0.75,
              color: Colors.white,
            ),
      ),
    );
  }
}

class TaskItemsListSection extends StatefulWidget {
  @override
  _TaskItemsListSectionState createState() => _TaskItemsListSectionState();
}

class _TaskItemsListSectionState extends State<TaskItemsListSection> {
  @override
  Widget build(BuildContext context) {
    var taskItems = Provider.of<Task>(context, listen: false).taskItems;
    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        return TaskItemWidget(
          taskItem: taskItems[index],
          onTaskItemClicked: () async {
            var taskItem = await Navigator.of(context).pushNamed(
                RouteName.EDIT_TASK_ITEM_PAGE,
                arguments: taskItems[index]);
            if (taskItem != null) {
              setState(() {
                Provider.of<Task>(context, listen: false).taskItems[index] =
                    taskItem;
              });
            }
          },
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
