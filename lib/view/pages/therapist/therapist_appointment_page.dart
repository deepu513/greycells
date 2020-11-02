import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/appointment/appointment_bloc.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/home/patient_home.dart';
import 'package:greycells/view/pages/all_appointments.dart';
import 'package:greycells/view/widgets/appointment_card.dart';
import 'package:provider/provider.dart';

class TherapistAppointmentsPage extends StatefulWidget {
  static const _NUMBER_OF_TABS = 2;
  const TherapistAppointmentsPage();

  @override
  _TherapistAppointmentsPageState createState() =>
      _TherapistAppointmentsPageState();
}

class _TherapistAppointmentsPageState extends State<TherapistAppointmentsPage> {
  List<Appointment> upcomingAppointments;
  @override
  void initState() {
    super.initState();
    upcomingAppointments =
        Provider.of<PatientHome>(context, listen: false).upcomingAppointments;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TherapistAppointmentsPage._NUMBER_OF_TABS,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    elevation: 4.0,
                    floating: true,
                    snap: true,
                    pinned: true,
                    forceElevated: innerBoxIsScrolled,
                    title: Text(
                      'Appointments',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black87),
                    ),
                    bottom: TabBar(
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          child: Text(
                            "UPCOMING",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "ALL",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: Expanded(
                child: Container(
                  child: TabBarView(
                    children: [
                      UpcomingAppointments(upcomingAppointments),
                      BlocProvider(
                        create: (context) => AppointmentBloc(),
                        child: AllAppointments(UserType.therapist),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

// TODO: Add empty state
class UpcomingAppointments extends StatelessWidget {
  final List<Appointment> upcomingAppointments;
  UpcomingAppointments(this.upcomingAppointments);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: AppointmentCard(
                upcomingAppointments[index], UserType.therapist),
          );
        },
        itemCount: upcomingAppointments.length,
      ),
    );
  }
}
