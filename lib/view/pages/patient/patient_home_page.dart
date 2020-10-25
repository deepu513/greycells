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
            _AppBarSection(),
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
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 4.0, 0.0),
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
      "Appointments",
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

class _AppBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        'Hi Deepak',
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Colors.black87),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteName.PATIENT_PROFILE_PAGE);
            },
            icon: Hero(
              tag: "profile_pic",
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
                radius: 16.0,
              ),
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
      height: 158.0,
      child: PageView.builder(
        itemCount: 2,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) => AltAppointmentCard(),
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

class AltAppointmentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Tue",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold),
                            overflow: TextOverflow.clip,
                          ),
                          Text(
                            "18",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    color: Color(0xFF100249),
                                    fontWeight: FontWeight.bold),
                            overflow: TextOverflow.clip,
                          ),
                          Text(
                            "Nov",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    color: Colors.cyan.shade500,
                                    fontWeight: FontWeight.bold),
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1.0,
                      indent: 4.0,
                      endIndent: 4.0,
                    ),
                    SizedBox(width: 4.0),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
                      radius: 24.0,
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
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
                          SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "at",
                                  style: Theme.of(context).textTheme.subtitle1,
                                  children: [
                                    TextSpan(
                                      text: " 12:30 pm",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(
                                              color: Color(0xFF100249),
                                              letterSpacing: 0.7,
                                              fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.meeting_room,
                      color: Colors.blueGrey,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Follow up",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Color(0xFF100249),
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: " meeting",
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.blue.shade50,
                      ),
                      child: Text(
                        "UPCOMING",
                        style: Theme.of(context).textTheme.caption.copyWith(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
