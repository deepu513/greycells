import 'package:flutter/material.dart';
import 'package:greycells/models/task/task.dart';
import 'package:greycells/models/task/task_item.dart';
import 'package:greycells/extensions.dart';
import 'package:intl/intl.dart';

class TaskItemsPage extends StatelessWidget {
  final Task task;

  const TaskItemsPage({Key key, @required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          task.title,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: TaskItemsListSection(task.taskItems),
      ),
    );
  }
}

class TaskItemsListSection extends StatelessWidget {
  final List<TaskItem> taskItems;

  TaskItemsListSection(this.taskItems);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        return _TaskItemWidget(
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

class _TaskItemWidget extends StatelessWidget {
  final TaskItem taskItem;

  const _TaskItemWidget({Key key, this.taskItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: !taskItem.file.name.isNullOrEmpty(),
            child: Container(
              height: 194.0,
              width: double.maxFinite,
              child: taskItem.file.name.isNullOrEmpty()
                  ? null
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        taskItem.file.name.withBaseUrlForImage(),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Text(
              taskItem.title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text.rich(TextSpan(
                text: "Expected by: ",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.black54),
                children: [
                  TextSpan(
                    text: _yetAnotherDateConversion(
                        taskItem.expectedCompletionDateTIme),
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ])),
          ),
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              taskItem.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(height: 1.4, wordSpacing: 0.7),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }

  String _yetAnotherDateConversion(String date) {
    try {
      DateFormat dateFormat = DateFormat("mm-dd-yyyy HH:mm:ss a");
      DateTime dateTime = dateFormat.parse(date);
      return DateFormat("EEE, dd MMM, yyyy").format(dateTime);
    } catch (e) {
      print(e);
    }
    return "";
  }
}
