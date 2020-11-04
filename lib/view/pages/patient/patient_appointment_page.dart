import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/appointment/appointment_bloc.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/view/pages/all_appointments.dart';

class PatientAppointmentPage extends StatelessWidget {
  const PatientAppointmentPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      elevation: 4.0,
      title: Text(
        'Appointments',
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Colors.black87),
      ),
    ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AppointmentBloc(),
          child: AllAppointments(UserType.patient),
        ),
      ),
    );
  }
}
