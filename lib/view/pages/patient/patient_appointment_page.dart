import 'package:flutter/material.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/view/widgets/appointment_card.dart';
import 'package:greycells/view/widgets/appointment_status_selector.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';

class PatientAppointmentPage extends StatelessWidget {
  const PatientAppointmentPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlowScrollBehaviour(),
          child: CustomScrollView(
            slivers: [
              AppointmentsAppBar(),
              SliverList(
                delegate: SliverChildListDelegate([
                  Divider(),
                  AppointmentStatusSelector((selectedStatus) {
                  }),
                  Divider(),
                ]),
              )
              AppointmentList(),
            ],
          ),
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
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Colors.black87),
      ),
    );
  }
}

class AppointmentList extends StatelessWidget {
  final List<Appointment> appointments;
  AppointmentList(this.appointments);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return AppointmentCard(appointments[index], CardViewer.patient);
        },
      ),
    );
  }
}
