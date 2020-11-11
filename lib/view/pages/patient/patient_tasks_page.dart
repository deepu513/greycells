import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:greycells/bloc/task/task_bloc.dart';
import 'package:greycells/bloc/task/task_status.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/task/task.dart';
import 'package:greycells/models/task/task_item.dart';
import 'package:greycells/models/task/task_item_page_args.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';
import 'package:greycells/view/widgets/task_status_widget.dart';
import 'package:intl/intl.dart';
import 'package:greycells/extensions.dart';

class PatientTasksPage extends StatelessWidget {
  const PatientTasksPage();

  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
      child: Scaffold(
        appBar: AppBar(
          elevation: 4.0,
          title: Text(
            'Tasks',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black87),
          ),
        ),
        body: SafeArea(
          child: BlocProvider<TaskBloc>(
            create: (context) => TaskBloc(),
            child: AllTasks(),
          ),
        ),
      ),
    );
  }
}

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  void initState() {
    super.initState();
    _loadAllTasks();
  }

  void _loadAllTasks() {
    BlocProvider.of<TaskBloc>(context).add(LoadAllTasks());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is TaskLoading)
          return Expanded(child: CenteredCircularLoadingIndicator());
        if (state is AllTasksLoaded)
          return CustomScrollView(
            slivers: [
              ...state.tasks.map((task) {
                return _TaskList(
                  task: task,
                );
              })
            ],
          );
        if (state is TasksEmpty) return Expanded(child: EmptyState());
        if (state is TasksError)
          return ErrorWithRetry(
            onRetryPressed: () {
              _loadAllTasks();
            },
          );
        return Container();
      },
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList({
    Key key,
    @required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: TaskSectionHeader(
        taskTitle: task.title,
        therapistName: task.therapist.fullName,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: _TaskItemWidget(
              taskItem: task.taskItems[index],
            ),
          ),
          childCount: task.taskItems.length,
        ),
      ),
    );
  }
}

class TaskSectionHeader extends StatelessWidget {
  const TaskSectionHeader({
    Key key,
    @required this.taskTitle,
    @required this.therapistName,
  }) : super(key: key);

  final String taskTitle;
  final String therapistName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          border: Border(
              bottom: BorderSide(color: Colors.blueGrey.shade100),
              top: BorderSide(color: Colors.blueGrey.shade100))),
      alignment: Alignment.centerLeft,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Flexible(
              child: Text(
                taskTitle,
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
            ),
            VerticalDivider(
              width: 24.0,
              color: Colors.blueGrey,
            ),
            RichText(
              text: TextSpan(
                text: "assigned by ",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.blueGrey, fontStyle: FontStyle.italic),
                children: [
                  TextSpan(
                    text: therapistName,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: Colors.blueGrey,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskItemWidget extends StatefulWidget {
  final TaskItem taskItem;

  const _TaskItemWidget({Key key, this.taskItem}) : super(key: key);

  @override
  __TaskItemWidgetState createState() => __TaskItemWidgetState();
}

class __TaskItemWidgetState extends State<_TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: () async {
          bool didUpdate = await Navigator.of(context).pushNamed(
            RouteName.TASK_ITEM_PAGE,
            arguments: TaskItemPageArgs(widget.taskItem, UserType.patient),
          );

          if (didUpdate == true) {
            setState(() {
              widget.taskItem.status = 1;
            });
          }
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: !widget.taskItem.file.name.isNullOrEmpty(),
              child: Container(
                height: 194.0,
                width: double.maxFinite,
                child: widget.taskItem.file.name.isNullOrEmpty()
                    ? null
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          widget.taskItem.file.name.withBaseUrlForImage(),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    widget.taskItem.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Spacer(),
                  TaskStatusWidget(TaskStatus.values[widget.taskItem.status])
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text.rich(TextSpan(
                  text: "Expected by ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black54),
                  children: [
                    TextSpan(
                      text: _yetAnotherDateConversion(
                          widget.taskItem.expectedCompletionDateTIme),
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
                widget.taskItem.description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(height: 1.4, wordSpacing: 0.7),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
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
