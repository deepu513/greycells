import 'package:flutter/material.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/view/widgets/outlined_chip.dart';

class AppointmentStatusSelector extends StatefulWidget {
  final ValueChanged<AppointmentStatus> onStatusSelected;

  AppointmentStatusSelector(this.onStatusSelected);

  @override
  _AppointmentStatusSelectorState createState() =>
      _AppointmentStatusSelectorState();
}

class _AppointmentStatusSelectorState extends State<AppointmentStatusSelector> {
  AppointmentStatus selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.filter_list, color: Colors.pink,),
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
