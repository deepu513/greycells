import 'package:flutter/material.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/appointment_card.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';

class TherapistAppointmentsPage extends StatelessWidget {
  final _numberOfTabs = 2;
  const TherapistAppointmentsPage();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _numberOfTabs,
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
            body: Expanded(child: Container(child: TabBarView(children: [
              UpcomingAppointments(),
              AllAppointments(),
            ],),),)
          ),
        ),
      ),
    );
  }
}

// TODO: Add empty state
class UpcomingAppointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: AppointmentCard(),
          );
        },
        itemCount: 20,
      ),
    );
  }
}

// TODO: Add empty state
class AllAppointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
