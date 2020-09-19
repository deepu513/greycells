import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/decider/decider_bloc.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';

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
    return BlocConsumer<DeciderBloc, DeciderState>(
      listener: (context, state) {
        if (state is NextPageDecided) {
          // Navigate to decided page
          Navigator.of(context)
              .pushNamedAndRemoveUntil(state.routeName, (route) => false);
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
    );
  }
}
