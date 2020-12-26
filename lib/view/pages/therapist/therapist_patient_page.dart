import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/patient/patient_bloc.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';
import 'package:greycells/view/widgets/circle_avatar_or_initials.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';

class TherapistPatientsPage extends StatelessWidget {
  const TherapistPatientsPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<PatientBloc>(
          create: (_) => PatientBloc(),
          child: _ActualPatientList(),
        ),
      ),
    );
  }
}

class _ActualPatientList extends StatefulWidget {
  @override
  __ActualPatientListState createState() => __ActualPatientListState();
}

class __ActualPatientListState extends State<_ActualPatientList> {
  @override
  void initState() {
    super.initState();
    _loadAllPatients();
  }

  _loadAllPatients() {
    BlocProvider.of<PatientBloc>(context).add(LoadPatients());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return await Future.delayed(Duration(milliseconds: 50), () {
              _loadAllPatients();
            });
      },
      child: BlocConsumer<PatientBloc, PatientState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is Loading) return CenteredCircularLoadingIndicator();
          if (state is Error)
            return ErrorWithRetry(
              onRetryPressed: () => _loadAllPatients(),
            );
          if (state is Empty) return EmptyState();
          if (state is Loaded)
            return ScrollConfiguration(
              behavior: NoGlowScrollBehaviour(),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 4.0,
                    forceElevated: true,
                    floating: true,
                    title: Text(
                      'Patients',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black87),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _PatientTile(
                          patient: state.patients[index],
                          onPatientTilePressed: () {
                            Navigator.of(context).pushNamed(
                                RouteName.PATIENT_PROFILE_DETAIL_PAGE,
                                arguments: state.patients[index]);
                          },
                        );
                      },
                      childCount: state.patients.length,
                    ),
                  ),
                ],
              ),
            );

          return Container();
        },
      ),
    );
  }
}

class _PatientTile extends StatelessWidget {
  final Patient patient;
  final VoidCallback onPatientTilePressed;

  const _PatientTile(
      {Key key, @required this.patient, @required this.onPatientTilePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: InkWell(
        onTap: onPatientTilePressed,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatarOrInitials(
                radius: 32.0,
                imageUrl: patient.file != null
                    ? patient.file.name.withBaseUrlForImage()
                    : "",
                stringForInitials: patient.fullName,
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
                        Text(patient.user.mobileNumber,
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
                        Text(patient.user.email,
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text("# No. of appointments:",
                            style: Theme.of(context).textTheme.bodyText1),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(patient.noOfAppointments.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontWeight: FontWeight.bold)),
                      ],
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
}
