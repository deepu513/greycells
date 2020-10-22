import 'package:flutter/material.dart';
import 'package:greycells/view/pages/patient/patient_appointment_page.dart';
import 'package:greycells/view/pages/patient/patient_goals_page.dart';
import 'package:greycells/view/pages/patient/patient_home_page.dart';
import 'package:greycells/view/pages/patient/patient_tasks_page.dart';
import 'package:greycells/view/pages/therapist/therapist_appointment_page.dart';
import 'package:greycells/view/pages/therapist/therapist_patient_page.dart';
import 'package:greycells/view/pages/therapist/thrapist_tasks_page.dart';
import 'package:greycells/view/pages/therapist_profile_page.dart';

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
    Icons.people_alt_outlined,
    Icons.people_alt,
    TherapistPatientsPage()
  ),
  Destination(
    "Tasks",
    Icons.fact_check_outlined,
    Icons.fact_check,
    TherapistTasksPage()
  ),
  Destination(
    "Profile",
    Icons.account_circle_outlined,
    Icons.account_circle,
    TherapistProfilePage(),
  )
];