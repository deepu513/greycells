import 'package:flutter/material.dart';

class AppointmentListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(horizontal:16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          style: Theme.of(context).textTheme.subtitle1,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          "Clinical Psychologist",
                          style: Theme.of(context).textTheme.caption,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.brown.shade50,
                      ),
                      child: Text(
                        "CANCELLED",
                        style: Theme.of(context).textTheme.caption.copyWith(
                            color: Colors.brown,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0),
                      ),
                    )
                  ],
                ),
                Divider(
                  indent: 60.0,
                  height: 20.0,
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
                        size: 20.0,
                      ),
                    ),
                    SizedBox(width: 24.0),
                    Text(
                      "on Wednesday, 26 October",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                Divider(
                  indent: 60.0,
                  height: 20.0,
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
                        size: 20.0,
                      ),
                    ),
                    SizedBox(width: 24.0),
                    Text(
                      "at 12:30 pm",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
