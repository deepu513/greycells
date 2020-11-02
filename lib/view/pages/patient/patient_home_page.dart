import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/home/patient_home.dart';
import 'package:greycells/models/therapist/therapist.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/appointment_card.dart';
import 'package:greycells/view/widgets/empty_state.dart';
import 'package:greycells/view/widgets/no_glow_scroll_behaviour.dart';
import 'package:greycells/view/widgets/therapist_list_tile.dart';
import 'package:provider/provider.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage();

  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  List<Appointment> upcomingAppointments;
  List<Therapist> availableTherapist;
  String patientName;

  @override
  void initState() {
    super.initState();
    upcomingAppointments =
        Provider.of<PatientHome>(context, listen: false).upcomingAppointments;
    availableTherapist =
        Provider.of<PatientHome>(context, listen: false).availableTherapists;
    patientName =
        Provider.of<PatientHome>(context, listen: false).patient.user.firstName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehaviour(),
        child: CustomScrollView(
          slivers: [
            _AppBarSection(patientName,
                "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: ScoreAndReportSection(),
                  ),
                  Visibility(
                    visible: upcomingAppointments != null &&
                        upcomingAppointments.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: UpcomingAppointmentHeaderSection(),
                    ),
                  ),
                  Visibility(
                    visible: upcomingAppointments != null &&
                        upcomingAppointments.isNotEmpty,
                    child: UpcomingAppointmentSection(upcomingAppointments),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 4.0, 0.0),
                    child: TherapistHeaderSection(),
                  ),
                  Visibility(
                    visible: availableTherapist == null ||
                        availableTherapist.isEmpty,
                    child: EmptyState(),
                  )
                ],
              ),
            ),
            Visibility(
              visible:
                  availableTherapist != null && availableTherapist.isNotEmpty,
              child: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return TherapistListTile(
                    therapist: availableTherapist[index],
                  );
                }, childCount: availableTherapist.length),
              ),
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
  final String patientName;
  final String profilePicUrl;

  _AppBarSection(this.patientName, this.profilePicUrl);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        'Hi $patientName',
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
                backgroundImage: NetworkImage(profilePicUrl),
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
  final List<Appointment> upcomingAppointments;

  UpcomingAppointmentSection(this.upcomingAppointments);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 158.0,
      child: PageView.builder(
        itemCount: upcomingAppointments.length,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) =>
            AppointmentCard(upcomingAppointments[index], UserType.patient),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class ScoreAndReportSection extends StatelessWidget {
  final List<HeaderCard> headerCards = [
    HeaderCard(
      title: "Checkout your assessment score",
      svgImageName: "score.svg",
      destination: RouteName.PATIENT_SCORE_PAGE,
    ),
    HeaderCard(
      title: "Checkout your reports",
      svgImageName: "report.svg",
      destination: RouteName.PATIENT_SCORE_PAGE,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: PageView.builder(
        itemCount: 2,
        controller: PageController(viewportFraction: 0.90),
        itemBuilder: (context, index) => headerCards[index],
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class HeaderCard extends StatelessWidget {
  final String svgImageName;
  final String title;
  final String destination;

  const HeaderCard({
    Key key,
    @required this.svgImageName,
    @required this.title,
    @required this.destination,
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
                  "images/$svgImageName",
                  height: 96.0,
                  width: 96.0,
                ),
                Expanded(
                  child: Text(
                    title,
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
                onTap: () {
                  Navigator.of(context).pushNamed(destination);
                },
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
