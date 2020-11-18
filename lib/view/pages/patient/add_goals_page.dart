import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:greycells/app_theme.dart';
import 'package:greycells/bloc/goals/goals_bloc.dart';
import 'package:greycells/models/goals/goal.dart';
import 'package:greycells/models/goals/goal_type.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';
import 'package:greycells/extensions.dart';

class AddGoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
      child: Scaffold(
          body: BlocProvider<GoalsBloc>(
        create: (_) => GoalsBloc(),
        child: _AllGoals(),
      )),
    );
  }
}

class _AllGoals extends StatefulWidget {
  @override
  __AllGoalsState createState() => __AllGoalsState();
}

class __AllGoalsState extends State<_AllGoals> {
  @override
  void initState() {
    super.initState();
    _loadAllGoals();
  }

  void _loadAllGoals() {
    BlocProvider.of<GoalsBloc>(context).add(LoadGoalsMaster());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return await Future.delayed(Duration(milliseconds: 100), () {
          _loadAllGoals();
        });
      },
      child: BlocConsumer<GoalsBloc, GoalsState>(
        listener: (context, state) {
          if (state is GoalCreated) {
            Navigator.of(context).pop(true);
          }

          if (state is DuplicateGoal) {
            widget.showErrorDialog(
                context: context,
                message:
                    "You have already addedd this goal. Please try to add another goal",
                showIcon: true,
                onPressed: () async {
                  Navigator.of(context).pop();
                  _loadAllGoals();
                });
          }
        },
        buildWhen: (prev, state) {
          return state is! DuplicateGoal;
        },
        builder: (context, state) {
          if (state is GoalsLoading) return CenteredCircularLoadingIndicator();
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
                      'Add Goals',
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
    );
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
              onAddAsGoalPressed: (goalType) {
                BlocProvider.of<GoalsBloc>(context)
                    .add(CreateGoal(goalTypeId: goalType.id));
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
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
  final void Function(GoalType goalType) onAddAsGoalPressed;

  const _GoalTypeWidget(
      {Key key, @required this.goalType, @required this.onAddAsGoalPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
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
                  OutlineButton(
                    child: Text(
                      "Add as goal".toUpperCase(),
                      style: Theme.of(context).textTheme.button.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    onPressed: () => onAddAsGoalPressed.call(goalType),
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
