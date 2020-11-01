import 'package:flutter/material.dart';
import 'package:greycells/models/appointment/appointment.dart';
import 'package:greycells/models/appointment/status.dart';
import 'package:greycells/view/widgets/appointment_status_widget.dart';
import 'package:greycells/view/widgets/vertical_date.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  AppointmentCard(this.appointment);

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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: VerticalDate(),
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
                    Expanded(child: AppointmentMetaInfo(appointment)),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentMetaInfo extends StatelessWidget {
  final Appointment appointment;
  AppointmentMetaInfo(this.appointment);
  @override
  Widget build(BuildContext context) {
    return Column(
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
          style: Theme.of(context).textTheme.bodyText1,
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
