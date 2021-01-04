import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:greycells/app_theme.dart';
import 'package:greycells/bloc/goals/goals_bloc.dart';
import 'package:greycells/models/goals/goal.dart';
import 'package:greycells/models/goals/goal_type.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:greycells/extensions.dart';

class PatientGoalsPage extends StatelessWidget {
  const PatientGoalsPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GoalsBloc>(
      create: (_) => GoalsBloc(),
      child: _ActualPatientGoals(),
    );
  }
}

class _ActualPatientGoals extends StatefulWidget {
  @override
  __ActualPatientGoalsState createState() => __ActualPatientGoalsState();
}

class __ActualPatientGoalsState extends State<_ActualPatientGoals> {
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _loadAllGoals();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var result =
                await Navigator.pushNamed(context, RouteName.ADD_GOALS_PAGE);
            if (result == true) {
              _loadAllGoals();
            }
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          elevation: 4.0,
          title: Text(
            'Goals',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black87),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return await Future.delayed(Duration(milliseconds: 50), () {
              _loadAllGoals();
            });
          },
          child: Column(
            children: [
              CalendarDateSelector(
                onDaySelected: (selectedDay) {
                  _selectedDay = selectedDay;
                  _loadAllGoals();
                },
              ),
              Expanded(
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
                                onMarkAsDonePressed: (goalType) {
                                  BlocProvider.of<GoalsBloc>(context).add(
                                    CompleteGoal(
                                      goalType.id,
                                      _selectedDay.formatToddMMyyyy(),
                                    ),
                                  );
                                },
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
            ],
          ),
        ),
      ),
    );
  }

  void _loadAllGoals() {
    BlocProvider.of<GoalsBloc>(context)
        .add(LoadCompletedGoals(_selectedDay.formatToddMMyyyy()));
  }
}

class _GoalsList extends StatelessWidget {
  final Goal goal;
  final void Function(GoalType goalType) onMarkAsDonePressed;

  const _GoalsList(
      {Key key, @required this.goal, @required this.onMarkAsDonePressed})
      : super(key: key);
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
              onMarkAsDonePressed: onMarkAsDonePressed,
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
  final void Function(GoalType goalType) onMarkAsDonePressed;

  const _GoalTypeWidget(
      {Key key, @required this.goalType, @required this.onMarkAsDonePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                children: [
                  Text(
                    goalType.name,
                    style: Theme.of(context).textTheme.headline6,
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
            if (goalType.status == "InProgress")
              Divider(
                height: 0.0,
              ),
            if (goalType.status == "InProgress")
              InkWell(
                onTap: () => onMarkAsDonePressed.call(goalType),
                splashColor: Colors.green.shade100,
                borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0)),
                child: Ink(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0)),
                    color: Colors.green.shade50,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Mark as complete".toUpperCase(),
                      style: Theme.of(context).textTheme.button.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7),
                    ),
                  ),
                ),
              )
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

class CalendarDateSelector extends StatefulWidget {
  final ValueChanged<DateTime> onDaySelected;

  CalendarDateSelector({@required this.onDaySelected});

  @override
  _CalendarDateSelectorState createState() => _CalendarDateSelectorState();
}

class _CalendarDateSelectorState extends State<CalendarDateSelector>
    with TickerProviderStateMixin {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
      startDay: DateTime.now().subtract(Duration(days: 30)),
      endDay: DateTime.now(),
      initialCalendarFormat: CalendarFormat.week,
      availableCalendarFormats: {CalendarFormat.week: 'Week'},
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.blue,
        todayColor: Colors.blue.shade200,
        outsideDaysVisible: false,
        weekendStyle: TextStyle(),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(color: const Color(0xFF616161))),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        rightChevronIcon: Icon(
          Icons.chevron_right_rounded,
          color: Colors.black87,
        ),
        leftChevronIcon: Icon(
          Icons.chevron_left_rounded,
          color: Colors.black87,
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    widget.onDaySelected.call(day);
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {}

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {}

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
}
