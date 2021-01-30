import 'package:flutter/material.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/view/widgets/appointment_status_widget.dart';
import 'package:greycells/view/widgets/circle_avatar_or_initials.dart';
import 'package:greycells/view/widgets/vertical_date.dart';
import 'package:greycells/extensions.dart';

class AppointmentCard extends StatefulWidget {
  final Appointment appointment;
  final UserType userType;
  final VoidCallback onTap;
  final bool showScrollIndicator;

  AppointmentCard(
      this.appointment, this.userType, this.onTap, this.showScrollIndicator);

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  String readableDate;

  @override
  void initState() {
    super.initState();
    readableDate = widget.appointment.date.convertToDateFormat("EEE dd MMM");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: _AppointmentSummary(
          appointment: widget.appointment,
          userType: widget.userType,
          readableDate: readableDate,
          showScrollIndicator: widget.showScrollIndicator,
        ),
      ),
    );
  }
}

class _AppointmentSummary extends StatelessWidget {
  final Appointment appointment;
  final UserType userType;
  final String readableDate;
  final bool showScrollIndicator;

  const _AppointmentSummary(
      {Key key,
      @required this.appointment,
      @required this.userType,
      @required this.readableDate,
      @required this.showScrollIndicator})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: showScrollIndicator,
          child: Container(
            width: 4.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    bottomLeft: Radius.circular(16.0)),
                color: Colors.blue),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatarOrInitials(
                        radius: 28.0,
                        imageUrl: userType == UserType.patient
                            ? appointment.therapist.file != null
                                ? appointment.therapist.file.name
                                    .withBaseUrlForImage()
                                : ""
                            : appointment.patient.file != null
                                ? appointment.patient.file.name
                                    .withBaseUrlForImage()
                                : "",
                        stringForInitials: userType == UserType.patient
                            ? appointment.therapist.fullName
                            : appointment.patient.fullName,
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                          child: AppointmentMetaInfo(appointment, userType)),
                      VerticalDivider(
                        thickness: 1.0,
                        indent: 4.0,
                        endIndent: 4.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: VerticalDate(
                            readableDate.split(" ")[0],
                            readableDate.split(" ")[1],
                            readableDate.split(" ")[2]),
                      ),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 4.0,
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
                        text: "${appointment.charge.meetingType.name}",
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
          ),
        ),
      ],
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
              ? appointment.therapist.fullName
              : appointment.patient.fullName,
          style: Theme.of(context).textTheme.headline6,
          overflow: TextOverflow.clip,
        ),
        Visibility(
          visible: userType == UserType.patient,
          child: Text(
            userType == UserType.patient
                ? appointment.therapist.therapistType.name
                : "",
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
                text: "at ",
                style: Theme.of(context).textTheme.subtitle2,
                children: [
                  TextSpan(
                    text: appointment.timeSlot.startTime,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
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
