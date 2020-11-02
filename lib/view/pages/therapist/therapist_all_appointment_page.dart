import 'package:flutter/material.dart';
import 'package:greycells/view/widgets/appointment_card.dart';

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
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemBuilder: (context, index) {
            return AppointmentCard();
          },
          itemCount: 20,
        ),
      ),
    );
  }
}
