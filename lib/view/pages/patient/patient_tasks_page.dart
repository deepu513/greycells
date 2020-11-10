import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/task/task_bloc.dart';
import 'package:greycells/models/task/task.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/circle_text.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';

class PatientTasksPage extends StatelessWidget {
  const PatientTasksPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return Expanded(
            child: TaskList(
              allTasks: state.tasks,
            ),
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

class TaskList extends StatelessWidget {
  final List<Task> allTasks;

  const TaskList({Key key, @required this.allTasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 8.0),
      itemBuilder: (context, index) {
        var task = allTasks[index];
        return ListTile(
          title: Text(
            task.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: RichText(
            text: TextSpan(
              text: "Assigned by: ",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black38),
              children: [
                TextSpan(
                  text:
                      "${task.therapist.user.firstName} ${task.therapist.user.lastName}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black87),
                ),
              ],
            ),
          ),
          trailing: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleText(
                  text: Text(
                    task.taskItems.length.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white),
                  ),
                  circleColor: Colors.black,
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text("items", style: Theme.of(context).textTheme.caption),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(RouteName.TASK_ITEMS_PAGE, arguments: task);
          },
        );
      },
      itemCount: allTasks.length,
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
