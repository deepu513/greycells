import 'package:flutter/material.dart';
import 'package:greycells/view/widgets/appointment_card.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';

class PatientAppointmentPage extends StatelessWidget {
  const PatientAppointmentPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehaviour(),
        child: CustomScrollView(
          slivers: [
            AppointmentsAppBar(),
            AppointmentList(),
          ],
        ),
      ),
    );
  }
}

class AppointmentsAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      title: Text(
        'Appointments',
        style:
            Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
      ),
      actions: [
        PopupMenuButton(
          onSelected: (value) {},
          icon: Icon(Icons.filter_list),
          itemBuilder: (context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                child: Text("Upcoming"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Completed"),
                value: 2,
              ),
              PopupMenuItem(
                child: Text("Cancelled"),
                value: 3,
              ),
            ];
          },
        )
      ],
    );
  }
}

class AppointmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return AppointmentCard();
    }, childCount: 20));
  }
}
