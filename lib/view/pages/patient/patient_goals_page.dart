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

class PatientGoalsPage extends StatefulWidget {
  const PatientGoalsPage();

  @override
  _PatientGoalsPageState createState() => _PatientGoalsPageState();
}

class _PatientGoalsPageState extends State<PatientGoalsPage> {
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
        body: BlocProvider<GoalsBloc>(
          create: (_) => GoalsBloc(),
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
                        SliverAppBar(
                          elevation: 4.0,
                          forceElevated: true,
                          floating: true,
                          title: Text(
                            'Goals',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.black87),
                          ),
                        ),
                        ...state.goals.map((goal) {
                          return _GoalsList(
                            goal: goal,
                          );
                        })
                      ],
                    ),
                  );
                if (state is GoalsEmpty) return Expanded(child: EmptyState());
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
    BlocProvider.of<GoalsBloc>(context).add(LoadGoalsByPatient());
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
              onMarkAsDonePressed: (goalType) {
                BlocProvider.of<GoalsBloc>(context).add(UpdateGoal(
                    status: 1,
                    patientGoalMappingId: goalType.patientGoalMappingId));
              },
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
        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
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
            SizedBox(
              height: 8.0,
            ),
            Visibility(
              visible: goalType.status == "InProgress",
              child: TextButton(
                child: Text(
                  "Mark as done".toUpperCase(),
                  style: Theme.of(context).textTheme.button.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.7),
                ),
                onPressed: () => onMarkAsDonePressed.call(goalType),
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
