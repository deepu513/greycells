import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/therapist/bloc/therapist_bloc.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/therapist_list_tile.dart';
import 'package:greycells/extensions.dart';

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
          listener: (context, state) {
            if (state is TherapistsLoadError) {
              showErrorDialog(
                  context: context,
                  message: state.error,
                  showIcon: true,
                  onPressed: () async {
                    Navigator.of(context).pop();
                  });
            }
          },
          builder: (context, state) {
            if (state is TherapistsLoading) {
              return CenteredCircularLoadingIndicator();
            }

            if (state is TherapistsLoaded) {
              return Container(
                child: state.therapists.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        itemBuilder: (context, index) {
                          return TherapistListTile(
                              therapist: state.therapists[index]);
                        },
                        itemCount: state.therapists.length)
                    : EmptyState(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
