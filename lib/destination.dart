import 'package:flutter/material.dart';
import 'package:greycells/view/pages/patient_appointment_page.dart';
import 'package:greycells/view/pages/patient_goals_page.dart';
import 'package:greycells/view/pages/patient_home_page.dart';
import 'package:greycells/view/pages/patient_tasks_page.dart';

class Destination {
  final String title;
  final IconData icon;
  final IconData activeIcon;
  final Widget body;

  const Destination(this.title, this.icon, this.activeIcon, this.body);
}

const List<Destination> allDestinations = <Destination>[
  Destination(
    "Home",
    Icons.home_outlined,
    Icons.home,
    PatientHomePage(),
  ),
  Destination(
    "Appointments",
    Icons.watch_later_outlined,
    Icons.watch_later,
    PatientAppointmentPage(),
  ),
  Destination(
    "Tasks",
    Icons.how_to_reg_outlined,
    Icons.how_to_reg,
    PatientTasksPage(),
  ),
  Destination(
    "Goals",
    Icons.toys_outlined,
    Icons.toys,
    PatientGoalsPage(),
  )
];
