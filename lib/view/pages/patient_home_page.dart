import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';
import 'package:greycells/view/widgets/therapist_list_tile.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage();

  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehaviour(),
        child: CustomScrollView(
          slivers: [
            AppBarSection(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: ScoreAndReportSection(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: UpcomingAppointmentHeaderSection(),
                  ),
                  UpcomingAppointmentSection(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TherapistHeaderSection(),
                  )
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return TherapistListTile();
              }, childCount: 20),
            )
          ],
        ),
      ),
    );
  }
}

class UpcomingAppointmentHeaderSection extends StatelessWidget {
  const UpcomingAppointmentHeaderSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Upcoming Appointments",
      style: Theme.of(context)
          .textTheme
          .headline6
          .copyWith(fontWeight: FontWeight.w700),
    );
  }
}

class TherapistHeaderSection extends StatelessWidget {
  const TherapistHeaderSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Therapists",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.w700),
        ),
        Spacer(),
        FlatButton(
          child: Text("View All"),
          onPressed: () {
            Navigator.of(context).pushNamed(RouteName.THERAPIST_LIST_PAGE);
          },
        )
      ],
    );
  }
}

class AppBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        'Hi Deepak',
        style:
            Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
              radius: 16.0,
            ),
          ),
        ),
      ],
      // Allows the user to reveal the app bar if they begin scrolling back
      // up the list of items.
      floating: true,
    );
  }
}

class UpcomingAppointmentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.0,
      child: PageView.builder(
        itemCount: 2,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) => UpcomingAppointmentCard(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class UpcomingAppointmentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          "Dr. Anne Hathaway",
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          "Clinical Psychologist",
                          style: Theme.of(context).textTheme.subtitle2,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  indent: 64.0,
                  height: 24.0,
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
                      ),
                    ),
                    SizedBox(width: 24.0),
                    Text(
                      "on Wednesday, 26 October",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                Divider(
                  indent: 64.0,
                  height: 24.0,
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
                      ),
                    ),
                    SizedBox(width: 24.0),
                    Text(
                      "at 12:30 pm",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class ScoreAndReportSection extends StatelessWidget {
  const ScoreAndReportSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: PageView.builder(
        itemCount: 2,
        controller: PageController(viewportFraction: 0.90),
        itemBuilder: (context, index) => HeaderCard(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

// TODO: Accept image, text and ontap parameters here
class HeaderCard extends StatelessWidget {
  const HeaderCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              gradient: LinearGradient(
                colors: [Color(0xFFC984A1), Color(0xFF4D2294)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "images/self_care_illustration.svg",
                  height: 80.0,
                  width: 80.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    "Checkout your assessment score",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.white, fontStyle: FontStyle.italic),
                    overflow: TextOverflow.clip,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                )
              ],
            ),
          ),
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(16.0),
                splashColor: Colors.white24,
              ),
            ),
          ),
        )
      ],
    );
  }
}
