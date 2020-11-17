import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/timer/timer_bloc.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/models/home/patient_home.dart';
import 'package:greycells/models/home/therapist_home.dart';
import 'package:greycells/models/task/assign_task_args.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/time_watcher.dart';
import 'package:greycells/view/widgets/appointment_status_widget.dart';
import 'package:greycells/view/widgets/circle_avatar_or_initials.dart';
import 'package:greycells/view/widgets/colored_page_section.dart';
import 'package:greycells/view/widgets/page_section.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/bloc/appointment/appointment_detail_bloc.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:provider/provider.dart';

class AppointmentDetailPage extends StatelessWidget {
  final UserType userType;
  final Appointment appointment;

  AppointmentDetailPage(this.userType, this.appointment);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentDetailBloc, AppointmentDetailState>(
      listener: (context, state) async {
        if (state is AppointmentCancelled) {
          await showSuccessDialog(
            context: context,
            message: "This appointment is cancelled successfully.",
            showIcon: true,
            onPressed: () => Navigator.of(context).pop(),
          );
          Navigator.of(context).pop(true);
        }

        if (state is AppointmentCompleted) {
          await showSuccessDialog(
            context: context,
            message:
                "This appointment is now marked as complete. You can assign tasks to your client.",
            showIcon: true,
            onPressed: () => Navigator.of(context).pop(),
          );
        }
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
                  child: BlocProvider<TimerBloc>(
                    create: (context) => TimerBloc(),
                    child: MainContent(
                      userType: userType,
                      appointment: appointment,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Visibility(
                    visible: !(appointment.status ==
                                AppointmentStatus.cancelled.index ||
                            appointment.status ==
                                AppointmentStatus.completed.index) &&
                        _shouldShowCancel(context, appointment.date,
                            appointment.timeSlot.startTime),
                    child: CancelAppointmentSection(
                      showLoading: state is AppointmentCancelling,
                      onCancelPressed: state is AppointmentCancelling ||
                              state is AppointmentCancelled
                          ? null
                          : () {
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

  bool _shouldShowCancel(
      BuildContext context, String appointmentDate, String appointmentTime) {
    String serverTime = userType == UserType.therapist
        ? Provider.of<TherapistHome>(context, listen: false).serverTimestamp
        : Provider.of<PatientHome>(context, listen: false).serverTimestamp;
    DateTime serverDateTime = serverTime
        .serverTimestampAsDate()
        .add(TimeWatcher.getInstance().elapsedDuration());
    DateTime aDate = appointmentDate.asDate();
    DateTime aTime = appointmentTime.timeAsDate();
    DateTime fullAppointmentDateTime =
        DateTime(aDate.year, aDate.month, aDate.day, aTime.hour, aTime.minute);

    return !fullAppointmentDateTime.difference(serverDateTime).isNegative;
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
    String serverTime = widget.userType == UserType.therapist
        ? Provider.of<TherapistHome>(context, listen: false).serverTimestamp
        : Provider.of<PatientHome>(context, listen: false).serverTimestamp;
    DateTime serverDateTime = serverTime
        .serverTimestampAsDate()
        .add(TimeWatcher.getInstance().elapsedDuration());
    DateTime aDate = widget.appointment.date.asDate();
    DateTime aTime = widget.appointment.timeSlot.startTime.timeAsDate();
    DateTime fullAppointmentDateTime =
        DateTime(aDate.year, aDate.month, aDate.day, aTime.hour, aTime.minute);
    BlocProvider.of<TimerBloc>(context)
        .add(InitiateTimer(serverDateTime, fullAppointmentDateTime));

    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.userType == UserType.patient
              ? _TappableSection(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        RouteName.THERAPIST_PROFILE_PAGE,
                        arguments: widget.appointment.therapist);
                  },
                  firstWidget: TherapistDetailsSection(
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
                  ),
                )
              : _TappableSection(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        RouteName.PATIENT_PROFILE_PAGE,
                        arguments: widget.appointment.patient);
                  },
                  firstWidget: PatientDetailsSection(
                    patientName: widget.appointment.patient.fullName,
                    patientMobileNumber:
                        widget.appointment.patient.user.mobileNumber,
                    profilePicUrl: widget.appointment.patient.file != null
                        ? widget.appointment.patient.file.name
                            .withBaseUrlForImage()
                        : "",
                  ),
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
          ScheduleDetailsSection(
              date: widget.appointment.date.asDate().readableDate(),
              time: widget.appointment.timeSlot.startTime),
          Divider(
            height: 32.0,
          ),
          AppointmentStatusDetails(widget.appointment, widget.userType),
          Visibility(
            visible: widget.userType == UserType.therapist,
            child: Divider(
              height: 32.0,
            ),
          ),
          Visibility(
            visible: widget.userType == UserType.therapist &&
                (widget.appointment.status !=
                    AppointmentStatus.cancelled.index),
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

  _onConferenceWillJoin({message}) {
    debugPrint("Conference joining $message");
  }

  _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined $message");
  }

  _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated $message");

    if (widget.userType == UserType.therapist) {
      widget.showConfirmationDialog(
        context: context,
        message:
            "We noticed the call being disconnected. Do you want to mark this appointment as complete?",
        onConfirmed: () {
          BlocProvider.of<AppointmentDetailBloc>(context)
              .add(CancelAppointment(widget.appointment.id));
          Navigator.of(context).pop();
        },
        onCancelled: () => Navigator.of(context).pop(),
      );
    }
  }

  _onError(error) {
    debugPrint("Conference error $error");
  }
}

class _TappableSection extends StatelessWidget {
  final Widget firstWidget;
  final VoidCallback onTap;

  const _TappableSection({
    Key key,
    @required this.firstWidget,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          firstWidget,
          SizedBox(
            height: 8.0,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16.0,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 4.0),
                Text(
                  "Click to see full profile",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          )
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

  const TherapistDetailsSection(
      {Key key,
      @required this.therapistName,
      @required this.therapistType,
      @required this.medicalCouncil,
      @required this.experience,
      @required this.profilePicUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
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
    );
  }
}

class PatientDetailsSection extends StatelessWidget {
  final String patientName;
  final String patientMobileNumber;
  final String profilePicUrl;

  const PatientDetailsSection({
    Key key,
    @required this.patientName,
    @required this.patientMobileNumber,
    @required this.profilePicUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
            text: "${appointment.charge.meetingType.name}",
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
  final String date;
  final String time;

  const ScheduleDetailsSection(
      {Key key, @required this.date, @required this.time})
      : super(key: key);

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
            description: date,
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
            description: time,
            descriptionIsItalic: false,
          ),
        ],
      ),
    );
  }
}

class CancelAppointmentSection extends StatelessWidget {
  final VoidCallback onCancelPressed;
  final bool showLoading;

  const CancelAppointmentSection(
      {Key key, @required this.onCancelPressed, @required this.showLoading})
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
              child: showLoading == true
                  ? SizedBox(
                      width: 16.0,
                      height: 16.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
                        strokeWidth: 2.0,
                      ),
                    )
                  : Icon(
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
  final UserType userType;

  AppointmentStatusDetails(this.appointment, this.userType);

  @override
  Widget build(BuildContext context) {
    if (appointment.status == AppointmentStatus.upcoming.index) {
      return BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          if (state is Finished)
            return OngoingAppointmentSection(
              remainingDuration: "00:00",
              onJoinAppointmentRequested: () {
                BlocProvider.of<AppointmentDetailBloc>(context)
                    .add(StartAppointment(
                  patientName: userType == UserType.patient
                      ? Provider.of<PatientHome>(context, listen: false)
                          .patient
                          .fullName
                      : appointment.patient.fullName,
                  therapistName: userType == UserType.patient
                      ? appointment.therapist.fullName
                      : Provider.of<TherapistHome>(context, listen: false)
                          .therapist
                          .fullName,
                  subject: userType == UserType.patient
                      ? "Meeting with ${appointment.therapist.fullName}"
                      : "Meeting with ${appointment.patient.fullName}",
                  displayName: userType == UserType.patient
                      ? Provider.of<PatientHome>(context, listen: false)
                          .patient
                          .fullName
                      : Provider.of<TherapistHome>(context, listen: false)
                          .therapist
                          .fullName,
                ));
              },
              canJoin: true,
            );

          if (state is TimeInPast) {
            return CompletedAppointmentSection();
          }

          return OngoingAppointmentSection(
            remainingDuration: state.readableDuration,
            onJoinAppointmentRequested: null,
            canJoin: false,
          );
        },
      );
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
  final String remainingDuration;
  final bool canJoin;
  final VoidCallback onJoinAppointmentRequested;

  const OngoingAppointmentSection(
      {Key key,
      @required this.onJoinAppointmentRequested,
      @required this.remainingDuration,
      @required this.canJoin})
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
                    canJoin
                        ? "Appointment started"
                        : "Starting in $remainingDuration",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    canJoin
                        ? "Your appointment has been started. Click here to join!"
                        : "You will be able to join the video call 5 minutes before the scheduled time.",
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
