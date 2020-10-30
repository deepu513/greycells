import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Tue",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold),
                            overflow: TextOverflow.clip,
                          ),
                          Text(
                            "18",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    color: Color(0xFF100249),
                                    fontWeight: FontWeight.bold),
                            overflow: TextOverflow.clip,
                          ),
                          Text(
                            "Nov",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    color: Colors.cyan.shade500,
                                    fontWeight: FontWeight.bold),
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
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
                    Expanded(
                      child: Column(
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
                            style: Theme.of(context).textTheme.subtitle2,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(
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
                      ),
                    ),
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
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.blue.shade50,
                      ),
                      child: Text(
                        "UPCOMING",
                        style: Theme.of(context).textTheme.caption.copyWith(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0),
                      ),
                    ),
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
