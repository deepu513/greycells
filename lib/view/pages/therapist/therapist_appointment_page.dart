import 'package:flutter/material.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/appointment_card.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';

// TODO: Add empty state
class TherapistAppointmentsPage extends StatelessWidget {
  const TherapistAppointmentsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehaviour(),
        child: CustomScrollView(
          slivers: [
            _AppBarSection(),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return AppointmentCard();
              }, childCount: 20),
            )
          ],
        ),
      ),
    );
  }
}

class _AppBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        'Upcoming Appointments (3)',
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Colors.black87),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RouteName.THERAPIST_APPOINTMENT_LIST_PAGE);
            },
            child: Text("View All")),
      ],
      // Allows the user to reveal the app bar if they begin scrolling back
      // up the list of items.
      floating: true,
    );
  }
}
