import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/decider/decider_bloc.dart';
import 'package:greycells/models/home/home.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';
import 'package:provider/provider.dart';

class DeciderPage extends StatefulWidget {
  @override
  _DeciderPageState createState() => _DeciderPageState();
}

class _DeciderPageState extends State<DeciderPage> {
  @override
  void initState() {
    super.initState();
    decideNextPage();
  }

  void decideNextPage() {
    BlocProvider.of<DeciderBloc>(context).add(DecideNextPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<DeciderBloc, DeciderState>(
          listener: (context, state) {
            if (state is NextPageDecided) {
              // Update home data
              var homeData = state.homeData;

              Provider.of<Home>(context, listen: false)
                ..patient = homeData.patient
                ..behaviourLastAttemptedQuestion =
                    homeData.behaviourLastAttemptedQuestion
                ..personalityLastAttemptedQuestion =
                    homeData.personalityLastAttemptedQuestion
                ..personalityScore = homeData.personalityScore
                ..behaviourScore = homeData.behaviourScore;
              // Navigate to decided page
              Navigator.of(context).pushNamedAndRemoveUntil(
                  state.routeName, (route) => false,
                  arguments: state.assessmentTestArguments);
            }
          },
          builder: (context, state) {
            if (state is NextPageDeciding) {
              return CenteredCircularLoadingIndicator();
            }

            if (state is DeciderError) {
              return ErrorWithRetry(onRetryPressed: decideNextPage);
            }

            return Container();
          },
        ),
      ),
    );
  }
}
