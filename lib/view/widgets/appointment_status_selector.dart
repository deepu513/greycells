import 'package:flutter/material.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/view/widgets/outlined_chip.dart';

class AppointmentStatusSelector extends StatefulWidget {
  final initialStatus;
  final ValueChanged<AppointmentStatus> onStatusSelected;

  AppointmentStatusSelector(this.onStatusSelected, this.initialStatus);

  @override
  _AppointmentStatusSelectorState createState() =>
      _AppointmentStatusSelectorState();
}

class _AppointmentStatusSelectorState extends State<AppointmentStatusSelector> {
  AppointmentStatus selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.initialStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Status:",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          OutlinedChip("Upcoming", selectedStatus == AppointmentStatus.upcoming,
              () {
            setState(() {
              selectedStatus = AppointmentStatus.upcoming;
            });

            widget.onStatusSelected.call(AppointmentStatus.upcoming);
          }),
          OutlinedChip(
              "Completed", selectedStatus == AppointmentStatus.completed, () {
            setState(() {
              selectedStatus = AppointmentStatus.completed;
            });
            widget.onStatusSelected.call(AppointmentStatus.completed);
          }),
          OutlinedChip(
              "Cancelled", selectedStatus == AppointmentStatus.cancelled, () {
            setState(() {
              selectedStatus = AppointmentStatus.cancelled;
            });
            widget.onStatusSelected.call(AppointmentStatus.cancelled);
          }),
        ],
      ),
    );
  }
}
