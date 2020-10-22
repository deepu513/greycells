import 'package:flutter/material.dart';
import 'package:greycells/view/widgets/appointment_list_tile.dart';

// TODO: Add empty state
class TherapistAllAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          "Appointments",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {},
            icon: Icon(Icons.filter_list),
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  child: Text("Upcoming"),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text("Completed"),
                  value: 2,
                ),
                PopupMenuItem(
                  child: Text("Cancelled"),
                  value: 3,
                ),
              ];
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemBuilder: (context, index) {
            return AppointmentListTile();
          },
          itemCount: 20,
        ),
      ),
    );
  }
}
