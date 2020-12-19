import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:greycells/bloc/assessment/assessment_bloc.dart';
import 'package:greycells/bloc/assessment/assessment_score_bloc.dart';
import 'package:greycells/bloc/goals/goals_bloc.dart';
import 'package:greycells/bloc/report/reports_bloc.dart';
import 'package:greycells/bloc/task/task_bloc.dart';
import 'package:greycells/bloc/task/task_status.dart';
import 'package:greycells/constants/gender.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/goals/goal.dart';
import 'package:greycells/models/goals/goal_type.dart';
import 'package:greycells/models/home/therapist_home.dart';
import 'package:greycells/models/patient/guardian/guardian.dart';
import 'package:greycells/models/patient/medical/medical_record.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/models/task/task.dart';
import 'package:greycells/models/task/task_item.dart';
import 'package:greycells/models/task/task_item_page_args.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/circle_avatar_or_initials.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/view/widgets/colored_page_section.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';
import 'package:greycells/view/widgets/network_image_with_error.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';
import 'package:greycells/view/widgets/page_section.dart';
import 'package:greycells/view/widgets/task_status_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PatientProfilePage extends StatelessWidget {
  final Patient patient;
  final bool showDetails;

  PatientProfilePage(this.patient, {this.showDetails = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87),
        ),
        actions: [
          Visibility(
            visible: showDetails == false,
            child: IconButton(
              icon: Icon(Icons.create_rounded),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteName.PATIENT_EDIT_PAGE);
              },
            ),
          )
        ],
      ),
      body: DefaultTabController(
        length: showDetails ? 6 : 2,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ProfileHeaderSection(patient),
              ),
              Divider(
                height: 2.0,
              ),
              TabBar(
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  labelStyle: Theme.of(context).textTheme.subtitle1,
                  unselectedLabelStyle: Theme.of(context).textTheme.subtitle1,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        "Personal",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Guardian",
                      ),
                    ),
                    if (showDetails)
                      Tab(
                        child: Text(
                          "Medical Records",
                        ),
                      ),
                    if (showDetails)
                      Tab(
                        child: Text(
                          "Assessment",
                        ),
                      ),
                    if (showDetails)
                      Tab(
                        child: Text(
                          "Tasks",
                        ),
                      ),
                    if (showDetails)
                      Tab(
                        child: Text(
                          "Goals",
                        ),
                      ),
                  ]),
              Expanded(
                child: Container(
                  child: TabBarView(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PersonalInformation(
                        patient: patient,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GuardianInformation(
                        guardian: patient.guardian,
                      ),
                    ),
                    if (showDetails)
                      BlocProvider<ReportsBloc>(
                        create: (context) => ReportsBloc(),
                        child: _MedicalRecordsTab(
                          medicalRecords: patient.medicalRecords,
                        ),
                      ),
                    if (showDetails)
                      BlocProvider<AssessmentScoreBloc>(
                        create: (context) => AssessmentScoreBloc(),
                        child: _AssessmentScore(
                          patientId: patient.id,
                        ),
                      ),
                    if (showDetails)
                      BlocProvider<TaskBloc>(
                        create: (context) => TaskBloc(),
                        child: AllTasks(
                          patientId: patient.id,
                        ),
                      ),
                    if (showDetails)
                      BlocProvider(
                        create: (context) => GoalsBloc(),
                        child: _ActualPatientGoals(
                          patientId: patient.id,
                        ),
                      ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileHeaderSection extends StatelessWidget {
  final Patient patient;
  ProfileHeaderSection(this.patient);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: "profile_pic",
          child: CircleAvatarOrInitials(
            radius: 32.0,
            imageUrl: patient.file != null
                ? patient.file.name.withBaseUrlForImage()
                : "",
            stringForInitials: patient.fullName,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patient.fullName,
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 4.0,
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.call_rounded,
                    size: 14.0,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  SelectableText(patient.user.mobileNumber,
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.alternate_email_rounded,
                    size: 14.0,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  SelectableText(patient.user.email,
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PersonalInformation extends StatelessWidget {
  final Patient patient;

  const PersonalInformation({Key key, @required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ColoredPageSection(
            icon: Icon(
              Icons.cake_rounded,
              color: Colors.blueGrey,
            ),
            description: patient.dateOfBirth,
            title: "Date of Birth",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: false,
          ),
          //* Date of birth
          SizedBox(
            height: 16.0,
          ),
          // * Gender
          ColoredPageSection(
            icon: Icon(
              Icons.wc_rounded,
              color: Colors.blueGrey,
            ),
            description: Gender.values()[patient.genderValue].toString(),
            title: "Gender",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: false,
          ),
          SizedBox(
            height: 16.0,
          ),
          // * Gender
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              shape: BoxShape.rectangle,
              color: Colors.grey.shade50,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                PageSection(
                  textColor: Colors.blueGrey,
                  icon: Icon(
                    Icons.height,
                    color: Colors.blueGrey,
                  ),
                  title: "Height",
                  description:
                      "${patient.healthRecord.heightInCm.toString()} cms",
                  descriptionIsItalic: false,
                ),
                SizedBox(
                  height: 24.0,
                ),
                PageSection(
                  textColor: Colors.blueGrey,
                  icon: Icon(
                    Icons.settings_input_svideo,
                    color: Colors.blueGrey,
                  ),
                  title: "Weight",
                  description:
                      "${patient.healthRecord.weightInKg.toString()} kgs",
                  descriptionIsItalic: false,
                ),
              ],
            ),
          ),

          SizedBox(
            height: 16.0,
          ),
          // * Address
          ColoredPageSection(
            icon: Icon(
              Icons.location_city,
              color: Colors.blueGrey,
            ),
            description: patient.address.readableAddress,
            title: "Contact Address",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: false,
          ),
        ],
      ),
    );
  }
}

class GuardianInformation extends StatelessWidget {
  final Guardian guardian;

  const GuardianInformation({Key key, @required this.guardian})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ColoredPageSection(
            icon: Icon(
              Icons.group_rounded,
              color: Colors.blueGrey,
            ),
            description: guardian.readableRelationship,
            title: "Relationship",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: false,
          ),
          SizedBox(
            height: 16.0,
          ),
          ColoredPageSection(
            icon: Icon(
              Icons.call_rounded,
              color: Colors.blueGrey,
            ),
            description: guardian.mobileNumber,
            title: "Contact Number",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: false,
          ),
          SizedBox(
            height: 16.0,
          ),
          ColoredPageSection(
            icon: Icon(
              Icons.alternate_email_rounded,
              color: Colors.blueGrey,
            ),
            description: guardian.email.isNullOrEmpty()
                ? "not available"
                : guardian.email,
            title: "Email ID",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: guardian.email.isNullOrEmpty(),
          ),
          SizedBox(
            height: 16.0,
          ),
          // * Address
          ColoredPageSection(
            icon: Icon(
              Icons.location_city_rounded,
              color: Colors.blueGrey,
            ),
            description: guardian.address == null
                ? "not available"
                : guardian.address.readableAddress,
            title: "Contact Address",
            textColor: Colors.blueGrey,
            sectionColor: Colors.grey.shade50,
            descriptionIsItalic: guardian.address == null,
          ),
        ],
      ),
    );
  }
}

class _ActualPatientGoals extends StatefulWidget {
  final int patientId;

  const _ActualPatientGoals({Key key, this.patientId}) : super(key: key);

  @override
  __ActualPatientGoalsState createState() => __ActualPatientGoalsState();
}

class __ActualPatientGoalsState extends State<_ActualPatientGoals> {
  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
      child: RefreshIndicator(
        onRefresh: () async {
          return await Future.delayed(Duration(milliseconds: 100), () {
            _loadAllGoals();
          });
        },
        child: BlocConsumer<GoalsBloc, GoalsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GoalsLoading)
              return CenteredCircularLoadingIndicator();
            if (state is AllGoalsLoaded)
              return ScrollConfiguration(
                behavior: NoGlowScrollBehaviour(),
                child: CustomScrollView(
                  slivers: [
                    ...state.goals.map((goal) {
                      return _GoalsList(
                        goal: goal,
                      );
                    })
                  ],
                ),
              );
            if (state is GoalsEmpty) return EmptyState();
            if (state is GoalsError)
              return ErrorWithRetry(
                onRetryPressed: () {
                  _loadAllGoals();
                },
              );
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadAllGoals();
  }

  void _loadAllGoals() {
    BlocProvider.of<GoalsBloc>(context)
        .add(LoadGoalsByPatient(patientId: widget.patientId));
  }
}

class _GoalsList extends StatelessWidget {
  final Goal goal;

  const _GoalsList({Key key, @required this.goal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: _GoalSectionHeader(
        goal: goal,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: _GoalTypeWidget(
              goalType: goal.goalsTypes[index],
            ),
          ),
          childCount: goal.goalsTypes.length,
        ),
      ),
    );
  }
}

class _GoalSectionHeader extends StatelessWidget {
  final Goal goal;

  const _GoalSectionHeader({Key key, @required this.goal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        goal.name,
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Colors.blueGrey, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _GoalTypeWidget extends StatelessWidget {
  final GoalType goalType;

  const _GoalTypeWidget({Key key, @required this.goalType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    goalType.name,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4.0),
                      color: getBackgroundColorForStatus(goalType.status),
                    ),
                    child: Text(
                      goalType.status == "InProgress"
                          ? "IN PROGRESS"
                          : "COMPLETE",
                      style: Theme.of(context).textTheme.overline.copyWith(
                            color: getTextColorForStatus(goalType.status),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getBackgroundColorForStatus(String status) {
    if (status == "InProgress") {
      return Colors.blue.shade50;
    }
    return Colors.green.shade50;
  }

  Color getTextColorForStatus(String status) {
    if (status == "InProgress") {
      return Colors.blue.shade700;
    }
    return Colors.green.shade700;
  }
}

class AllTasks extends StatefulWidget {
  final int patientId;

  const AllTasks({Key key, @required this.patientId}) : super(key: key);

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
    BlocProvider.of<TaskBloc>(context).add(LoadPatientTasks(widget.patientId,
        forTherapist: true,
        therapistId:
            Provider.of<TherapistHome>(context, listen: false).therapist.id));
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
        listener: (context, state) {},
        builder: (context, state) {
          if (state is TaskLoading) return CenteredCircularLoadingIndicator();
          if (state is AllTasksLoaded)
            return ScrollConfiguration(
              behavior: NoGlowScrollBehaviour(),
              child: CustomScrollView(
                slivers: [
                  ...state.tasks.map((task) {
                    return _TaskList(
                      task: task,
                    );
                  })
                ],
              ),
            );
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
            Expanded(
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
        onTap: () {
          Navigator.of(context).pushNamed(
            RouteName.TASK_ITEM_PAGE,
            arguments: TaskItemPageArgs(widget.taskItem, UserType.therapist),
          );
        },
        borderRadius: BorderRadius.circular(8.0),
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
                              : widget.taskItem.file.name.withBaseUrlForImage(),
                          boxFit: BoxFit.cover,
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
      DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss a");
      DateTime dateTime = dateFormat.parse(date);
      return DateFormat("EEE, dd MMM, yyyy").format(dateTime);
    } catch (e) {
      debugPrint(e.toString());
    }
    return "";
  }
}

class _AssessmentScore extends StatefulWidget {
  final int patientId;

  const _AssessmentScore({Key key, this.patientId}) : super(key: key);

  @override
  __AssessmentScoreState createState() => __AssessmentScoreState();
}

class __AssessmentScoreState extends State<_AssessmentScore> {
  @override
  void initState() {
    super.initState();
    _loadAllAssessments();
  }

  void _loadAllAssessments() {
    BlocProvider.of<AssessmentScoreBloc>(context)
        .add(LoadAssessmentScores(widget.patientId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssessmentScoreBloc, AssessmentScoreState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AssessmentScoreLoading)
          return CenteredCircularLoadingIndicator();
        if (state is AssessmentScoreLoaded)
          return ScrollConfiguration(
            behavior: NoGlowScrollBehaviour(),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteName.FULL_SCORE_PAGE,
                        arguments: state.assessmentScores[index]);
                  },
                  title: Text(
                    "Assessment #${index + 1}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                      "Completed on ${state.assessmentScores[index].assessment.createdDate.asDate().readableDate()}"),
                  trailing: Icon(Icons.chevron_right_rounded),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: state.assessmentScores.length,
            ),
          );
        if (state is AssessmentScoreEmpty) return EmptyState();
        if (state is AssessmentError)
          return ErrorWithRetry(
            onRetryPressed: () {
              _loadAllAssessments();
            },
          );
        return Container();
      },
    );
  }
}

class _MedicalRecordsTab extends StatefulWidget {
  final List<MedicalRecord> medicalRecords;

  const _MedicalRecordsTab({Key key, @required this.medicalRecords})
      : super(key: key);

  @override
  __MedicalRecordsTabState createState() => __MedicalRecordsTabState();
}

class __MedicalRecordsTabState extends State<_MedicalRecordsTab> {
  @override
  Widget build(BuildContext context) {
    if (widget.medicalRecords == null ||
        (widget.medicalRecords != null && widget.medicalRecords.isEmpty))
      return EmptyState(
        description: "Couldn't find any medical records",
      );
    else
      return ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                if (widget.medicalRecords[index].file.type == "image") {
                  Navigator.of(context).pushNamed(RouteName.IMAGE_VIEWER_PAGE,
                      arguments: widget.medicalRecords[index].file.name
                          .withBaseUrlForImage());
                } else {
                  BlocProvider.of<ReportsBloc>(context).add(
                      DownloadReportWithUrl(widget
                          .medicalRecords[index].file.name
                          .withBaseUrlForImage()));
                }
              },
              leading: widget.medicalRecords[index].file.type == "image"
                  ? Image.network(
                      widget.medicalRecords[index].file.name
                          .withBaseUrlForImage(),
                      width: 80.0,
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.insert_drive_file),
              title: Text(
                widget.medicalRecords[index].file.name,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: Icon(Icons.arrow_circle_down_rounded),
                iconSize: 20.0,
                onPressed: () {
                  BlocProvider.of<ReportsBloc>(context).add(
                      DownloadReportWithUrl(widget
                          .medicalRecords[index].file.name
                          .withBaseUrlForImage()));
                },
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
                indent: 16.0,
                endIndent: 16.0,
              ),
          itemCount: widget.medicalRecords.length);
  }
}
