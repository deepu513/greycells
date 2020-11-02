import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/appointment/appointment_bloc.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/view/pages/all_appointments.dart';
import 'package:greycells/view/widgets/appointment_card.dart';
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
              BlocProvider(
                create: (context) => AppointmentBloc(),
                child: AllAppointments(UserType.patient),
              ),
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
          return AppointmentCard(appointments[index], UserType.patient);
        },
      ),
    );
  }
}
