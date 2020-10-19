import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
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