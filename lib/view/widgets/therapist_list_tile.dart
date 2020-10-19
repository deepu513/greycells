import 'package:flutter/material.dart';

class TherapistListTile extends StatelessWidget {
  const TherapistListTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Dr. Anne Hathaway",
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      "Clinical Psychologist",
                      style: Theme.of(context).textTheme.subtitle2,
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "Speaks: English, Hindi, Marathi",
                      style: Theme.of(context).textTheme.caption,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  "5 years exp",
                  style: Theme.of(context).textTheme.caption,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
