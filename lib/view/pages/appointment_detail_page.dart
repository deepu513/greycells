import 'package:flutter/material.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/view/widgets/appointment_status_widget.dart';
import 'package:greycells/view/widgets/colored_page_section.dart';
import 'package:greycells/view/widgets/vertical_date.dart';
import 'package:greycells/extensions.dart';

class AppointmentDetailPage extends StatefulWidget {
  final UserType userType;
  final Appointment appointment;

  AppointmentDetailPage(this.userType, this.appointment);

  @override
  _AppointmentDetailPageState createState() => _AppointmentDetailPageState();
}

class _AppointmentDetailPageState extends State<AppointmentDetailPage> {
  String readableDate;
  @override
  void initState() {
    super.initState();
    readableDate = widget.appointment.date.convertToDateFormat("EEE dd MMM");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          'Appointment Details',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppointmentSummary(
                      appointment: widget.appointment,
                      userType: widget.userType,
                      readableDate: readableDate,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    AppointmentStatusDetails(widget.appointment),
                    SizedBox(
                      height: 16.0,
                    ),
                    Visibility(
                      //visible: widget.userType == UserType.therapist,
                      child: AddTasksSection(),
                    ),
                  ],
                ),
              ),
            ),
            InteractWithAppointmentSection(),
          ],
        ),
      ),
    );
  }
}

class AppointmentSummary extends StatelessWidget {
  final Appointment appointment;
  final UserType userType;
  final String readableDate;

  const AppointmentSummary(
      {Key key,
      @required this.appointment,
      @required this.userType,
      @required this.readableDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
                  radius: 32.0,
                ),
                SizedBox(width: 16.0),
                Expanded(child: AppointmentMetaInfo(appointment, userType)),
                VerticalDivider(
                  thickness: 1.0,
                  indent: 4.0,
                  endIndent: 4.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: VerticalDate(readableDate.split(" ")[0],
                      readableDate.split(" ")[1], readableDate.split(" ")[2]),
                ),
              ],
            ),
          ),
          Divider(
            height: 24.0,
          ),
          Row(
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
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
              Spacer(),
              AppointmentStatusWidget(
                  AppointmentStatus.values[appointment.status])
            ],
          ),
        ],
      ),
    );
  }
}

class AppointmentMetaInfo extends StatelessWidget {
  final Appointment appointment;
  final UserType userType;

  AppointmentMetaInfo(this.appointment, this.userType);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          userType == UserType.patient
              ? "${appointment.therapist.user.firstName} ${appointment.therapist.user.lastName}"
              : "${appointment.patient.user.firstName} ${appointment.patient.user.lastName}",
          style: Theme.of(context).textTheme.headline6,
          overflow: TextOverflow.clip,
        ),
        Visibility(
          visible: userType == UserType.patient,
          child: Text(
            appointment.therapist.therapistType.name,
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.clip,
          ),
        ),
        SizedBox(
          height: 2.0,
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
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
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
    );
  }
}

class AppointmentStatusDetails extends StatelessWidget {
  final Appointment appointment;

  AppointmentStatusDetails(this.appointment);

  @override
  Widget build(BuildContext context) {
    if (appointment.status == AppointmentStatus.upcoming.index) {
      return OngoingAppointmentSection();
    }
    if (appointment.status == AppointmentStatus.cancelled.index) {
      return CancelledAppointmentSection();
    }
    if (appointment.status == AppointmentStatus.completed.index) {
      return CompletedAppointmentSection();
    }
    return Container();
  }
}

class OngoingAppointmentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          shape: BoxShape.rectangle,
          color: Colors.green),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Appointment Started",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  """Your appointment has been started. Click on 'Join Appointment' to continue.""",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white,
                      ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UpcomingAppointmentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredPageSection(
      icon: Icon(
        Icons.info_outline_rounded,
        size: 20.0,
        color: Colors.blue.shade700,
      ),
      title: "Info",
      description:
          "Your appointment is as per the schedule and you will be able to join the video call 5 minutes before the scheduled time.",
      textColor: Colors.blue.shade700,
      sectionColor: Colors.blue.shade50,
    );
  }
}

class CancelledAppointmentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredPageSection(
      icon: Icon(
        Icons.info_outline_rounded,
        size: 20.0,
        color: Colors.brown.shade700,
      ),
      title: "Info",
      description: "This appointment has been cancelled.",
      textColor: Colors.brown.shade700,
      sectionColor: Colors.brown.shade50,
    );
  }
}

class CompletedAppointmentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredPageSection(
      icon: Icon(
        Icons.info_outline_rounded,
        size: 20.0,
        color: Colors.teal.shade700,
      ),
      title: "Info",
      description: "This appointment is now complete.",
      textColor: Colors.teal.shade700,
      sectionColor: Colors.teal.shade50,
    );
  }
}

class AddTasksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8.0),
      splashColor: Colors.purple.shade100,
      child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.purple.shade100),
              shape: BoxShape.rectangle,
              color: Colors.purple.shade50),
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  Icons.add_circle_rounded,
                  color: Colors.purple.shade700,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assign Tasks",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.purple, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "Click on this section to assign tasks to the patient.",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.purple,
                          ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class InteractWithAppointmentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
