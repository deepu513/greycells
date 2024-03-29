import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greycells/models/task/task_item.dart';
import 'package:greycells/extensions.dart';

class TaskItemWidget extends StatelessWidget {
  final VoidCallback onTaskItemClicked;
  final TaskItem taskItem;
  final bool showEditIcon;

  const TaskItemWidget(
      {Key key,
      this.taskItem,
      this.onTaskItemClicked,
      this.showEditIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: onTaskItemClicked,
        borderRadius: BorderRadius.circular(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: !taskItem.filePath.isNullOrEmpty(),
              child: Container(
                height: 194.0,
                width: double.maxFinite,
                child: taskItem.filePath == null
                    ? null
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          File(taskItem.filePath),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: Row(
                children: [
                  Text(
                    taskItem.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Spacer(),
                  Icon(
                    Icons.edit,
                    size: 20.0,
                  )
                ],
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
                      text: taskItem.readableDate ??
                          taskItem.expectedCompletionDateTIme
                              .expectedCompletionAsDate()
                              .readableDate(),
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
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
