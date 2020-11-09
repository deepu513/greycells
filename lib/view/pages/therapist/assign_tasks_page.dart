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
              child: TaskSubSection(),
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
        hintText: Strings.taskTitle,
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TasksCountSection(count: 0),
        Spacer(),
        TaskAddButton(
          onPressed: () {},
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
            )
          ]),
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
