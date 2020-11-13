import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/models/task/assign_task_args.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/appointment_status_widget.dart';
import 'package:greycells/view/widgets/circle_avatar_or_initials.dart';
import 'package:greycells/view/widgets/colored_page_section.dart';
import 'package:greycells/view/widgets/page_section.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/bloc/appointment/appointment_detail_bloc.dart';

//TODO: UI for loading appointment cancellation
class AppointmentDetailPage extends StatelessWidget {
  final UserType userType;
  final Appointment appointment;

  AppointmentDetailPage(this.userType, this.appointment);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentDetailBloc, AppointmentDetailState>(
      listener: (context, state) {
        if (state is AppointmentCancelled) {}
      },
      builder: (context, state) {
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
                    child: MainContent(
                  userType: userType,
                  appointment: appointment,
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Visibility(
                    // TODO: Add condition here to check the meeting time.
                    visible:
                        appointment.status != AppointmentStatus.cancelled.index,
                    child: CancelAppointmentSection(
                      onCancelPressed: () {
                        BlocProvider.of<AppointmentDetailBloc>(context)
                            .add(CancelAppointment(appointment.id));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MainContent extends StatefulWidget {
  final UserType userType;
  final Appointment appointment;

  const MainContent(
      {Key key, @required this.userType, @required this.appointment})
      : super(key: key);

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  String readableDate;

  @override
  void initState() {
    super.initState();
    readableDate = widget.appointment.date.convertToDateFormat("EEE dd MMM");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.userType == UserType.patient
              ? TherapistDetailsSection(
                  therapistName: widget.appointment.therapist.fullName,
                  therapistType:
                      widget.appointment.therapist.therapistType.name,
                  medicalCouncil: widget.appointment.therapist.medicalCouncil,
                  experience:
                      widget.appointment.therapist.totalExperience.toString(),
                  profilePicUrl: widget.appointment.therapist.file != null
                      ? widget.appointment.therapist.file.name
                          .withBaseUrlForImage()
                      : "",
                  onTherapistProfileRequested: () {
                    Navigator.of(context).pushNamed(
                        RouteName.THERAPIST_PROFILE_PAGE,
                        arguments: widget.appointment.therapist);
                  },
                )
              : PatientDetailsSection(
                  patientName: widget.appointment.patient.fullName,
                  patientMobileNumber:
                      widget.appointment.patient.user.mobileNumber,
                  profilePicUrl: widget.appointment.patient.file != null
                      ? widget.appointment.patient.file.name
                          .withBaseUrlForImage()
                      : "",
                  onPatientProfileRequested: () {
                    Navigator.of(context).pushNamed(
                        RouteName.PATIENT_PROFILE_PAGE,
                        arguments: widget.appointment.patient);
                  },
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
            child: AddTasksSection(
              onAddTasksPressed: () {
                Navigator.of(context).pushNamed(RouteName.ADD_TASKS_PAGE,
                    arguments: AssignTaskArgs()
                      ..appointmentId = widget.appointment.id
                      ..therapistId = widget.appointment.therapist.id
                      ..patientId = widget.appointment.patient.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TherapistDetailsSection extends StatelessWidget {
  final String therapistName;
  final String therapistType;
  final String medicalCouncil;
  final String profilePicUrl;
  final String experience;
  final VoidCallback onTherapistProfileRequested;

  const TherapistDetailsSection(
      {Key key,
      @required this.therapistName,
      @required this.therapistType,
      @required this.medicalCouncil,
      @required this.experience,
      @required this.onTherapistProfileRequested,
      @required this.profilePicUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTherapistProfileRequested,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatarOrInitials(
              radius: 32.0,
              imageUrl: profilePicUrl,
              stringForInitials: therapistName,
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
  final String profilePicUrl;
  final VoidCallback onPatientProfileRequested;

  const PatientDetailsSection(
      {Key key,
      @required this.patientName,
      @required this.patientMobileNumber,
      @required this.profilePicUrl,
      @required this.onPatientProfileRequested})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPatientProfileRequested,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatarOrInitials(
            radius: 32.0,
            imageUrl: profilePicUrl,
            stringForInitials: patientName,
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patientName,
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.w700),
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
      ),
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
  final VoidCallback onCancelPressed;

  const CancelAppointmentSection({Key key, @required this.onCancelPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showConfirmationDialog(
          context: context,
          message: "Are you sure, you want to cancel this appointment?",
          onConfirmed: () {
            Navigator.of(context).pop();
            onCancelPressed.call();
          },
          onCancelled: () => Navigator.of(context).pop(),
        );
      },
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
        ),
      ),
    );
  }
}

class AppointmentStatusDetails extends StatelessWidget {
  final Appointment appointment;

  AppointmentStatusDetails(this.appointment);

  @override
  Widget build(BuildContext context) {
    // TODO: Add condition here to check the meeting time.
    if (appointment.status == AppointmentStatus.upcoming.index) {
      return OngoingAppointmentSection();
    }
    if (appointment.status == AppointmentStatus.upcoming.index) {
      return UpcomingAppointmentSection();
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
  final VoidCallback onJoinAppointmentRequested;

  const OngoingAppointmentSection(
      {Key key, @required this.onJoinAppointmentRequested})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onJoinAppointmentRequested,
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
  final VoidCallback onAddTasksPressed;

  const AddTasksSection({Key key, @required this.onAddTasksPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAddTasksPressed,
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
