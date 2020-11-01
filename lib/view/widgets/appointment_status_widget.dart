import 'package:flutter/material.dart';
import 'package:greycells/models/appointment/status.dart';

class AppointmentStatusWidget extends StatelessWidget {
  final AppointmentStatus appointmentStatus;

  AppointmentStatusWidget(this.appointmentStatus);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4.0),
        color: getBackgroundColorForStatus(appointmentStatus),
      ),
      child: Text(
        appointmentStatus.toString().toUpperCase(),
        style: Theme.of(context).textTheme.caption.copyWith(
            color: getTextColorForStatus(appointmentStatus),
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0),
      ),
    );
  }

  Color getBackgroundColorForStatus(AppointmentStatus status) {
    if (status == AppointmentStatus.upcoming) {
      return Colors.blue.shade50;
    }

    if (status == AppointmentStatus.cancelled) {
      return Colors.brown.shade50;
    }

    if (status == AppointmentStatus.completed) {
      return Colors.teal.shade50;
    }

    return Colors.blue.shade50;
  }

  Color getTextColorForStatus(AppointmentStatus status) {
    if (status == AppointmentStatus.upcoming) {
      return Colors.blue.shade700;
    }

    if (status == AppointmentStatus.cancelled) {
      return Colors.brown.shade700;
    }

    if (status == AppointmentStatus.completed) {
      return Colors.teal.shade700;
    }

    return Colors.blue.shade700;
  }
}
