import 'package:flutter/material.dart';
import 'package:greycells/route/route_name.dart';
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
                return _TherapistsUpcomingAppointmentTile();
              }, childCount: 20),
            )
          ],
        ),
      ),
    );
  }
}

class _TherapistsUpcomingAppointmentTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
                      radius: 24.0,
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Anne Hathaway",
                          style: Theme.of(context).textTheme.subtitle1,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          "+917666131849",
                          style: Theme.of(context).textTheme.caption,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  indent: 60.0,
                  height: 20.0,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.purple.shade50),
                      child: Icon(
                        Icons.date_range,
                        color: Colors.purple,
                        size: 20.0,
                      ),
                    ),
                    SizedBox(width: 24.0),
                    Text(
                      "on Wednesday, 26 October",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                Divider(
                  indent: 60.0,
                  height: 20.0,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.pink.shade50),
                      child: Icon(
                        Icons.access_time,
                        color: Colors.pink,
                        size: 20.0,
                      ),
                    ),
                    SizedBox(width: 24.0),
                    Text(
                      "at 12:30 pm",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ],
            )),
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
