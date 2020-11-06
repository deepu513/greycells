import 'package:flutter/material.dart';
import 'package:greycells/constants/user_type.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/appointment/appointment_status.dart';
import 'package:greycells/view/widgets/appointment_status_widget.dart';
import 'package:greycells/view/widgets/page_section.dart';
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              AppointmentSummary(
                appointment: widget.appointment,
                userType: widget.userType,
                readableDate: readableDate,
              ),
              AppointmentStatusDetails(),
              Visibility(
                visible: widget.userType == UserType.therapist,
                child: AddTasksSection(),
              ),
              CancelAppointmentSection(),
            ],
          ),
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
          Divider(height: 24.0,),
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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AddTasksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CancelAppointmentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
