import 'package:flutter/material.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/view/widgets/appointment_status_widget.dart';
import 'package:greycells/view/widgets/colored_page_section.dart';
import 'package:greycells/view/widgets/page_section.dart';
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
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.userType == UserType.patient
                        ? TherapistDetailsSection(
                            therapistName:
                                "${widget.appointment.therapist.user.firstName} ${widget.appointment.therapist.user.lastName}",
                            therapistType:
                                widget.appointment.therapist.therapistType.name,
                            medicalCouncil:
                                widget.appointment.therapist.medicalCouncil,
                            experience: widget
                                .appointment.therapist.totalExperience
                                .toString())
                        : PatientDetailsSection(
                            patientName:
                                "${widget.appointment.patient.user.firstName} ${widget.appointment.patient.user.lastName}",
                            patientMobileNumber:
                                widget.appointment.patient.user.mobileNumber,
                          ),
                    Divider(
                      height: 32.0,
                    ),
                    AppointmentSummary(
                      appointment: widget.appointment,
                      readableDate: readableDate,
                    ),
                    Divider(
                      height: 32.0,
                    ),
                    ScheduleDetailsSection(),
                    Divider(
                      height: 32.0,
                    ),
                    AppointmentStatusDetails(widget.appointment),
                    Visibility(
                      visible: widget.userType == UserType.therapist,
                      child: Divider(
                        height: 32.0,
                      ),
                    ),
                    Visibility(
                      visible: widget.userType == UserType.therapist,
                      child: AddTasksSection(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: CancelAppointmentSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class TherapistDetailsSection extends StatelessWidget {
  final String therapistName;
  final String therapistType;
  final String medicalCouncil;
  final String experience;

  const TherapistDetailsSection(
      {Key key,
      @required this.therapistName,
      @required this.therapistType,
      @required this.medicalCouncil,
      @required this.experience})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
              radius: 32.0,
            ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    therapistName ?? "",
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    therapistType ?? "",
                    style: Theme.of(context).textTheme.subtitle2,
                    overflow: TextOverflow.clip,
                  ),
                  Visibility(
                    visible: medicalCouncil != null,
                    child: Text(
                      medicalCouncil ?? "",
                      style: Theme.of(context).textTheme.caption,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              thickness: 1.0,
              width: 32.0,
              indent: 8.0,
              endIndent: 8.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.purple.shade50),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    experience,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.purple, fontWeight: FontWeight.w700),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "years",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.black87, fontStyle: FontStyle.italic),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "exp",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.black87, fontStyle: FontStyle.italic),
                  overflow: TextOverflow.clip,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PatientDetailsSection extends StatelessWidget {
  final String patientName;
  final String patientMobileNumber;

  const PatientDetailsSection(
      {Key key, @required this.patientName, @required this.patientMobileNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
          radius: 32.0,
        ),
        SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              patientName,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black87, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.call,
                  size: 14.0,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 4.0,
                ),
                SelectableText(
                  patientMobileNumber,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 14.0),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class AppointmentSummary extends StatelessWidget {
  final Appointment appointment;
  final String readableDate;

  const AppointmentSummary(
      {Key key, @required this.appointment, @required this.readableDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
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
                text: " meeting. ",
                style: Theme.of(context).textTheme.caption,
              ),
              TextSpan(
                text: "${appointment.duration} minutes.",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        Spacer(),
        AppointmentStatusWidget(AppointmentStatus.values[appointment.status])
      ],
    );
  }
}

class ScheduleDetailsSection extends StatelessWidget {
  const ScheduleDetailsSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        shape: BoxShape.rectangle,
        color: Colors.grey.shade50,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PageSection(
            textColor: Colors.blueGrey,
            icon: Icon(
              Icons.event_rounded,
              size: 20.0,
              color: Colors.blueGrey,
            ),
            title: "Date",
            description: "Tuesday, 25 October, 2020",
            descriptionIsItalic: false,
          ),
          SizedBox(
            height: 24.0,
          ),
          PageSection(
            textColor: Colors.blueGrey,
            icon: Icon(
              Icons.schedule_rounded,
              size: 20.0,
              color: Colors.blueGrey,
            ),
            title: "Time",
            description: "12:30 PM",
            descriptionIsItalic: false,
          ),
        ],
      ),
    );
  }
}

class CancelAppointmentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8.0),
      splashColor: Colors.brown.shade100,
      child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.brown.shade100),
            color: Colors.brown.shade50,
            shape: BoxShape.rectangle,
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  Icons.cancel_rounded,
                  color: Colors.brown,
                  size: 20.0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cancel this appointment?",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.brown),
                    ),
                  ],
                ),
              ),
            ],
          )),
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
    return InkWell(
      onTap: () {},
      splashColor: Colors.white24,
      borderRadius: BorderRadius.circular(8.0),
      child: Ink(
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
                Icons.video_call_rounded,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Appointment Started",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    "Your appointment has been started. Click here to join!",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white,
                        ),
                  )
                ],
              ),
            ),
          ],
        ),
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
          "You will be able to join the video call 5 minutes before the scheduled time.",
      textColor: Colors.blue.shade700,
      sectionColor: Colors.blue.shade50,
      descriptionIsItalic: false,
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
      descriptionIsItalic: false,
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
      descriptionIsItalic: false,
    );
  }
}

class AddTasksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF455a64)),
            shape: BoxShape.rectangle,
          ),
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  Icons.add_circle_rounded,
                  color: Color(0xFF455a64),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assign Tasks",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Color(0xFF455a64),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "Click on this section to assign tasks to the patient.",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Color(0xFF455a64),
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
