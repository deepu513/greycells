import 'package:flutter/material.dart';

class AppointmentListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 0.5))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
              radius: 24.0,
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  "26 October, 2020",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            Spacer(),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.teal.shade50,
              ),
              child: Text(
                "COMPLETED",
                style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.teal,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
