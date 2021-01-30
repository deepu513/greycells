import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:greycells/app_theme.dart';
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
import 'package:greycells/view/widgets/task_status_widget.dart';
import 'package:intl/intl.dart';
import 'package:greycells/extensions.dart';

class TherapistTasksPage extends StatelessWidget {
  const TherapistTasksPage();

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
  String selectedPatient;
  List<Task> existingTasks;

  @override
  void initState() {
    super.initState();
    _loadAllTasks();
  }

  void _loadAllTasks() {
    BlocProvider.of<TaskBloc>(context).add(LoadAllTasks(UserType.patient));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return Future.delayed(Duration(milliseconds: 100), () {
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
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                    floating: true,
                    elevation: 4.0,
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
                          _showBottomSheet(context, state.patientNames);
                        },
                      )
                    ]),
                ...state.tasks.map((task) {
                  return _TaskList(
                    task: task,
                  );
                })
              ],
            );
          if (state is FilterApplied) {
            return CustomScrollView(
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

  _showBottomSheet(context, List<String> patientNames) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      context: context,
      isDismissible: true,
      builder: (newContext) {
        return PatientsFilter(
            patientNames: patientNames,
            onPatientSelected: (patient) {
              selectedPatient = patient;
              _applyFilter(patient, patientNames);
            },
            selectedPatientName: selectedPatient);
      },
    );
  }

  _applyFilter(String patientName, List<String> allPatientNames) {
    BlocProvider.of<TaskBloc>(context).add(ApplyFilter(
        existingTasks, patientName, allPatientNames,
        userType: UserType.patient));
  }
}

class PatientsFilter extends StatefulWidget {
  final List<String> patientNames;
  final ValueChanged<String> onPatientSelected;
  final String selectedPatientName;

  const PatientsFilter(
      {Key key,
      @required this.patientNames,
      @required this.onPatientSelected,
      this.selectedPatientName})
      : super(key: key);

  @override
  _PatientsFilterState createState() => _PatientsFilterState();
}

class _PatientsFilterState extends State<PatientsFilter> {
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
            "Select a patient to filter tasks",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: widget.patientNames.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.patientNames[index]),
                leading: widget.selectedPatientName != null &&
                        widget.selectedPatientName == widget.patientNames[index]
                    ? Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.green,
                      )
                    : Icon(Icons.panorama_fish_eye_rounded),
                onTap: () {
                  widget.onPatientSelected.call(widget.patientNames[index]);
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
        patientName: task.patient.fullName,
        onEditTaskRequested: () async {
          var result = await Navigator.of(context)
              .pushNamed(RouteName.EDIT_TAK_PAGE, arguments: task);

          if (result == true) {
            BlocProvider.of<TaskBloc>(context)
                .add(LoadAllTasks(UserType.patient));
          }
        },
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
  final VoidCallback onEditTaskRequested;

  const TaskSectionHeader({
    Key key,
    @required this.taskTitle,
    @required this.patientName,
    @required this.noOfItems,
    @required this.onEditTaskRequested,
  }) : super(key: key);

  final String taskTitle;
  final String patientName;
  final int noOfItems;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
          color: Colors.teal.shade50,
          border: Border(
              bottom: BorderSide(color: Colors.teal.shade100),
              top: BorderSide(color: Colors.teal.shade100))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: taskTitle,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.teal, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text:
                            " ($noOfItems ${noOfItems > 1 ? 'items' : 'item'})",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.teal),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                RichText(
                  text: TextSpan(
                    text: "assigned to ",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.teal, fontStyle: FontStyle.italic),
                    children: [
                      TextSpan(
                        text: patientName,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Colors.teal,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit,),
            onPressed: onEditTaskRequested,
          )
        ],
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
      color: Colors.teal,
      child: InkWell(
        onTap: () async {
          var didUpdate = await Navigator.of(context).pushNamed(
            RouteName.TASK_ITEM_PAGE,
            arguments: TaskItemPageArgs(widget.taskItem, UserType.therapist),
          );

          if (didUpdate == true) {
            setState(() {
              widget.taskItem.status = 1;
            });
          }
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              Text.rich(TextSpan(
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
                  ])),
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
    );
  }

  String _yetAnotherDateConversion(String date) {
    try {
      if (date.contains("AM") || date.contains("PM")) {
        DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss a");
        DateTime dateTime = dateFormat.parse(date);
        return DateFormat("EEE, dd MMM, yyyy").format(dateTime);
      } else {
        return date.fromddMMyyyy().readableDate();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return "";
  }
}
