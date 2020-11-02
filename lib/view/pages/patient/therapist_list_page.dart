import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/therapist/bloc/therapist_bloc.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';
import 'package:greycells/view/widgets/therapist_list_tile.dart';

// TODO: Add pagination here
class TherapistListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 4.0,
          title: Text(
            'All Therapists',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black87),
          )),
      body: SafeArea(
        child: BlocConsumer<TherapistBloc, TherapistState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TherapistsLoading) {
              return CenteredCircularLoadingIndicator();
            }

            if (state is TherapistsLoaded) {
              return Container(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    itemBuilder: (context, index) {
                      return TherapistListTile(
                          therapist: state.therapists[index]);
                    },
                    itemCount: state.therapists.length),
              );
            }

            if (state is TherapistsEmpty) {
              return EmptyState();
            }

            if (state is TherapistsLoadError) {
              return ErrorWithRetry(
                onRetryPressed: () {},
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
