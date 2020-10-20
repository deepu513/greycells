import 'package:flutter/material.dart';
import 'package:greycells/view/pages/patient_appointment_page.dart';
import 'package:greycells/view/pages/patient_goals_page.dart';
import 'package:greycells/view/pages/patient_home_page.dart';
import 'package:greycells/view/pages/patient_tasks_page.dart';
import 'package:greycells/view/pages/therapist/therapist_appointment_page.dart';
import 'package:greycells/view/pages/therapist/therapist_patient_page.dart';
import 'package:greycells/view/pages/therapist/thrapist_profile_page.dart';
import 'package:greycells/view/pages/therapist/thrapist_tasks_page.dart';

class Destination {
  final String title;
  final IconData icon;
  final IconData activeIcon;
  final Widget body;

  const Destination(this.title, this.icon, this.activeIcon, this.body);
}

const List<Destination> patientDestinations = <Destination>[
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


const List<Destination> therapistDestinations = <Destination>[
  Destination(
    "Appointments",
    Icons.watch_later_outlined,
    Icons.watch_later,
    TherapistAppointmentsPage(),
  ),
  Destination(
    "Patients",
    Icons.how_to_reg_outlined,
    Icons.how_to_reg,
    TherapistPatientsPage()
  ),
  Destination(
    "Tasks",
    Icons.how_to_reg_outlined,
    Icons.how_to_reg,
    TherapistTasksPage()
  ),
  Destination(
    "Profile",
    Icons.account_circle_outlined,
    Icons.account_circle,
    TherapistProfilePage(),
  )
];