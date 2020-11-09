import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/view/widgets/empty_state.dart';

class AssignTasksPage extends StatelessWidget {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TaskTitleInput(
                showError: false,
                onTitleChanged: (title) {},
              ),
            ),
            Divider(
              height: 8.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: TaskSubSection(
                onAddPressed: () {
                  showTaskAddDialog(
                      context: context,
                      onCancelled: () {
                        Navigator.of(context).pop();
                      },
                      onConfirmed: () {});
                },
              ),
            ),
            Divider(
              height: 8.0,
            ),
            Expanded(
              child: false
                  ? TaskListSection()
                  : EmptyState(
                      svgImageName: "to_do_list.svg",
                      title: "Add tasks for your patient",
                      description: "Click on 'ADD' to create.",
                    ),
            ),
            TaskCreateAssignButton(
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void showTaskAddDialog(
      {@required BuildContext context,
      @required VoidCallback onConfirmed,
      @required VoidCallback onCancelled}) {
    showModal(
        context: context,
        configuration: FadeScaleTransitionConfiguration(),
        builder: (context) {
          return AlertDialog(
            title: Text("Add Task"),
            content: SingleChildScrollView(
              child: TaskDetailInput(),
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
                onPressed: onConfirmed,
              ),
            ],
          );
        });
  }
}

class TaskDetailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            width: double.maxFinite,
            alignment: Alignment.center,
            padding: EdgeInsets.all(24.0),
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
            child: PickImageMessage(),
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
          onChanged: (value) {},
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
          onChanged: (value) {},
        ),
        SizedBox(
          height: 8.0,
        ),
        InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            showDatePicker(
              context: context,
              initialDate: DateTime.now(), // Refer step 1
              firstDate: DateTime(2000),
              lastDate: DateTime(2025),
            );
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
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: "Expected date of completion\n",
                    style: Theme.of(context).textTheme.button.copyWith(
                          color: Colors.black87,
                        ),
                    children: [
                      TextSpan(
                        text: "(tap to select)",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.black38),
                      ),
                    ],
                  ),
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
  @override
  Widget build(BuildContext context) {
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
        TasksCountSection(count: 0),
        Spacer(),
        TaskAddButton(
          onPressed: onAddPressed,
        )
      ],
    );
  }
}

class TasksCountSection extends StatelessWidget {
  final int count;

  const TasksCountSection({Key key, @required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "$count ",
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
        "ADD",
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

class TaskListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Text(index.toString());
      },
    );
  }
}
