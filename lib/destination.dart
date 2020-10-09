import 'package:flutter/material.dart';

class Destination {
  final String title;
  final IconData icon;
  final IconData activeIcon;

  const Destination(this.title, this.icon, this.activeIcon);
}

const List<Destination> allDestinations = <Destination>[
  Destination("Home", Icons.home_outlined, Icons.home),
  Destination("Appointments", Icons.watch_later_outlined, Icons.watch_later),
  Destination("Tasks", Icons.how_to_reg_outlined, Icons.how_to_reg),
  Destination("Goals", Icons.toys_outlined, Icons.toys)
];
