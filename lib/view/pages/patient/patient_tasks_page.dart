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
import 'package:greycells/view/widgets/network_image_with_error.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';
import 'package:greycells/view/widgets/task_status_widget.dart';
import 'package:intl/intl.dart';
import 'package:greycells/extensions.dart';

class PatientTasksPage extends StatelessWidget {
  const PatientTasksPage();

  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
      child: Scaffold(
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
  String selectedTherapist;
  List<Task> existingTasks;

  @override
  void initState() {
    super.initState();
    _loadAllTasks();
  }

  void _loadAllTasks() {
    BlocProvider.of<TaskBloc>(context).add(LoadAllTasks(UserType.therapist));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return await Future.delayed(Duration(milliseconds: 100), () {
          _loadAllTasks();
        });
      },
      child: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is AllTasksLoaded) {
            this.existingTasks = state.tasks;
          }
        },
        builder: (context, state) {
          if (state is TaskLoading) return CenteredCircularLoadingIndicator();
          if (state is AllTasksLoaded)
            return ScrollConfiguration(
              behavior: NoGlowScrollBehaviour(),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 4.0,
                    forceElevated: true,
                    floating: true,
                    title: Text(
                      'Tasks',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black87),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.filter_list_rounded),
                        onPressed: () {
                          _showBottomSheet(context, state.therapistNames);
                        },
                      )
                    ],
                  ),
                  ...state.tasks.map((task) {
                    return _TaskList(
                      task: task,
                    );
                  })
                ],
              ),
            );
          if (state is FilterApplied) {
            return ScrollConfiguration(
              behavior: NoGlowScrollBehaviour(),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 4.0,
                    forceElevated: true,
                    floating: true,
                    title: Text(
                      'Tasks',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black87),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.filter_list_rounded),
                        onPressed: () {
                          _showBottomSheet(context, state.filteredNames);
                        },
                      )
                    ],
                  ),
                  ...state.tasks.map((task) {
                    return _TaskList(
                      task: task,
                    );
                  })
                ],
              ),
            );
          }
          if (state is TasksEmpty) return EmptyState();
          if (state is TasksError)
            return ErrorWithRetry(
              onRetryPressed: () {
                _loadAllTasks();
              },
            );
          return Container();
        },
      ),
    );
  }

  _showBottomSheet(context, List<String> therapistNames) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      context: context,
      isDismissible: true,
      builder: (newContext) {
        return TherapistFilter(
            therapistNames: therapistNames,
            onTherapistSelected: (therapist) {
              selectedTherapist = therapist;
              _applyFilter(therapist, therapistNames);
            },
            selectedTherapistType: selectedTherapist);
      },
    );
  }

  _applyFilter(String therapistName, List<String> allTherapistNames) {
    BlocProvider.of<TaskBloc>(context).add(ApplyFilter(
        existingTasks, therapistName, allTherapistNames,
        userType: UserType.therapist));
  }
}

class TherapistFilter extends StatefulWidget {
  final List<String> therapistNames;
  final ValueChanged<String> onTherapistSelected;
  final String selectedTherapistType;

  const TherapistFilter(
      {Key key,
      @required this.therapistNames,
      @required this.onTherapistSelected,
      this.selectedTherapistType})
      : super(key: key);

  @override
  _TherapistFilterState createState() => _TherapistFilterState();
}

class _TherapistFilterState extends State<TherapistFilter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Select a therapist to filter tasks",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: widget.therapistNames.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.therapistNames[index]),
                leading: widget.selectedTherapistType != null &&
                        widget.selectedTherapistType ==
                            widget.therapistNames[index]
                    ? Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.green,
                      )
                    : Icon(Icons.panorama_fish_eye_rounded),
                onTap: () {
                  widget.onTherapistSelected.call(widget.therapistNames[index]);
                  Navigator.pop(context);
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        )
      ],
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
        noOfItems: task.taskItems.length,
        therapistName: task.therapist.fullName,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
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
    @required this.noOfItems,
  }) : super(key: key);

  final String taskTitle;
  final String therapistName;
  final int noOfItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.black26),
          )),
      alignment: Alignment.centerLeft,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: taskTitle,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: " ($noOfItems ${noOfItems > 1 ? 'items' : 'item'})",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              width: 24.0,
              color: Colors.black,
            ),
            RichText(
              text: TextSpan(
                text: "assigned by ",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.black54, fontStyle: FontStyle.italic),
                children: [
                  TextSpan(
                    text: therapistName,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.black87,
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
    return Stack(children: [
      Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(colors: [
              Colors.orange,
              Colors.orange.shade400,
              Colors.orange.shade300,
            ], stops: [
              0.1,
              0.7,
              1
            ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: widget.taskItem.file != null &&
                    !widget.taskItem.file.name.isNullOrEmpty(),
                child: Container(
                  height: 194.0,
                  width: double.maxFinite,
                  child: widget.taskItem.file != null &&
                          widget.taskItem.file.name.isNullOrEmpty()
                      ? null
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: NetworkImageWithError(
                            imageUrl: widget.taskItem.file == null
                                ? ""
                                : widget.taskItem.file.name
                                    .withBaseUrlForImage(),
                            boxFit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    widget.taskItem.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  Spacer(),
                  TaskStatusWidget(TaskStatus.values[widget.taskItem.status])
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              Text.rich(
                TextSpan(
                  text: "Expected by: ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                  children: [
                    TextSpan(
                      text: _yetAnotherDateConversion(
                          widget.taskItem.expectedCompletionDateTIme),
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              Text.rich(
                TextSpan(
                  text: "Description: ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                  children: [
                    TextSpan(
                      text: widget.taskItem.description,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          height: 1.4,
                          wordSpacing: 0.7,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned.fill(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                var didUpdate = await Navigator.of(context).pushNamed(
                  RouteName.TASK_ITEM_PAGE,
                  arguments:
                      TaskItemPageArgs(widget.taskItem, UserType.patient),
                );

                if (didUpdate == true) {
                  setState(() {
                    widget.taskItem.status = 1;
                  });
                }
              },
              borderRadius: BorderRadius.circular(8.0),
              splashColor: Colors.white24,
            ),
          ),
        ),
      )
    ]);
  }

  String _yetAnotherDateConversion(String date) {
    try {
      DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss a");
      DateTime dateTime = dateFormat.parse(date);
      return DateFormat("EEE, dd MMM, yyyy").format(dateTime);
    } catch (e) {
      debugPrint(e.toString());
    }
    return "";
  }
}
