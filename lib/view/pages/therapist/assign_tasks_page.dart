import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/picker/image_picker_bloc.dart';
import 'package:greycells/bloc/task/task_bloc.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/task/task.dart';
import 'package:greycells/models/task/task_item.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:greycells/extensions.dart';

class AssignTasksPage extends StatefulWidget {
  @override
  _AssignTasksPageState createState() => _AssignTasksPageState();
}

class _AssignTasksPageState extends State<AssignTasksPage> {
  Task task;

  @override
  void initState() {
    super.initState();
    task = Task();
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
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    child: TaskTitleInput(
                      showError: false,
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
                      onAddPressed: () {
                        showTaskAddDialog(
                          context: context,
                          onCancelled: () {
                            Navigator.of(context).pop();
                          },
                          onTaskItemAdded: (taskItem) {
                            if (taskItem != null) {
                              setState(() => task.taskItems.add(taskItem));
                            }
                          },
                        );
                      },
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
                            title: "Assign tasks to your patient!",
                            description:
                                "Click on 'ADD ITEM' to add a task item.",
                          ),
                  ),
                  TaskCreateAssignButton(
                    onPressed: task.taskItems.isNotEmpty ? () {} : null,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void showTaskAddDialog(
      {@required BuildContext context,
      @required ValueChanged<TaskItem> onTaskItemAdded,
      @required VoidCallback onCancelled}) {
    TaskItem taskItem = TaskItem();
    taskItem.expectedCompletionDateTIme = DateTime.now().formatToddMMyyyy();

    showModal(
        context: context,
        configuration: FadeScaleTransitionConfiguration(),
        builder: (context) {
          return AlertDialog(
            title: Text("Add Item"),
            content: SingleChildScrollView(
              child: TaskItemInput(
                onTitleChanged: (title) {
                  taskItem.title = title;
                },
                onDescriptionChanged: (description) {
                  taskItem.description = description;
                },
                onImageSelected: (imagePath) {
                  taskItem.filePath = imagePath;
                },
                onDateSelected: (date) {
                  taskItem.expectedCompletionDateTIme = date.formatToddMMyyyy();
                },
              ),
            ),
            actions: [
              FlatButton(
                child: Text(
                  Strings.cancel.toUpperCase(),
                  textAlign: TextAlign.end,
                ),
                onPressed: onCancelled,
              ),
              FlatButton(
                child: Text(
                  "ADD".toUpperCase(),
                  textAlign: TextAlign.end,
                ),
                onPressed: () {
                  onTaskItemAdded.call(taskItem);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

class TaskItemInput extends StatefulWidget {
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDescriptionChanged;
  final ValueChanged<String> onImageSelected;
  final ValueChanged<DateTime> onDateSelected;

  const TaskItemInput(
      {Key key,
      @required this.onTitleChanged,
      @required this.onDescriptionChanged,
      @required this.onImageSelected,
      @required this.onDateSelected})
      : super(key: key);

  @override
  _TaskItemInputState createState() => _TaskItemInputState();
}

class _TaskItemInputState extends State<TaskItemInput> {
  String initialDate;

  @override
  void initState() {
    super.initState();
    initialDate = DateTime.now().formatToddMMyyyy();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocProvider<ImagePickerBloc>(
          create: (_) => ImagePickerBloc(),
          child: Builder(
            builder: (context) {
              return InkWell(
                onTap: () {
                  BlocProvider.of<ImagePickerBloc>(context)
                      .add(PickImage(ImageSource.gallery));
                },
                child: Container(
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(24.0),
                  decoration: BoxDecoration(border: Border.all(width: 0.5)),
                  child: PickImageMessage(
                    onImageSelected: widget.onImageSelected,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        TextField(
          maxLines: 1,
          maxLength: 100,
          buildCounter: (BuildContext context,
                  {int currentLength, int maxLength, bool isFocused}) =>
              null,
          decoration: InputDecoration(
            labelText: "Title*",
          ),
          textInputAction: TextInputAction.next,
          autofocus: false,
          keyboardType: TextInputType.text,
          onChanged: widget.onTitleChanged,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
        SizedBox(
          height: 8.0,
        ),
        TextField(
          maxLines: null,
          decoration: InputDecoration(
            labelText: "Description*",
          ),
          autofocus: false,
          keyboardType: TextInputType.multiline,
          onChanged: widget.onDescriptionChanged,
        ),
        SizedBox(
          height: 8.0,
        ),
        InkWell(
          onTap: () async {
            FocusScope.of(context).unfocus();

            final DateTime pickedDateTime = await showDatePicker(
              context: context,
              initialDate: DateTime.now(), // Refer step 1
              firstDate: DateTime(2000),
              lastDate: DateTime(2025),
            );

            if (pickedDateTime != null)
              widget.onDateSelected.call(pickedDateTime);

            setState(() {
              initialDate = pickedDateTime.formatToddMMyyyy();
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_rounded,
                  size: 20.0,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expected date of completion",
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: Colors.black87,
                          ),
                    ),
                    Text(
                      initialDate,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "(tap to change)",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.black38),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PickImageMessage extends StatelessWidget {
  final ValueChanged<String> onImageSelected;

  const PickImageMessage({Key key, @required this.onImageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerBloc, ImagePickerState>(
      listener: (context, state) {},
      builder: (context, imagePickerState) {
        if (imagePickerState is StateImagePicked) {
          onImageSelected.call(imagePickerState.pickedImageFile.path);

          return Image.file(
            imagePickerState.pickedImageFile,
            fit: BoxFit.cover,
          );
        }
        return Column(
          children: [
            Icon(Icons.add_photo_alternate_outlined),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "Add an image (optional)",
              style: Theme.of(context).textTheme.caption,
            )
          ],
        );
      },
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
        errorText: showError ? ErrorMessages.EMAIL_ERROR_MESSAGE : null,
      ),
      autofocus: false,
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
    return ListView.builder(
      itemBuilder: (context, index) {
        return Text(taskItems[index].title);
      },
      itemCount: taskItems.length,
    );
  }
}
