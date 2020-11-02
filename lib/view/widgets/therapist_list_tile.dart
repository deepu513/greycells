import 'package:flutter/material.dart';
import 'package:greycells/models/therapist/therapist.dart';
import 'package:greycells/route/route_name.dart';

class TherapistListTile extends StatelessWidget {
  final Therapist therapist;
  const TherapistListTile({Key key, @required this.therapist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RouteName.THERAPIST_PROFILE_PAGE, arguments: therapist);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://urbanbalance.com/wp-content/uploads/2019/04/new-therapist.jpg"),
                radius: 28.0,
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${therapist.user.firstName} ${therapist.user.lastName}",
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    therapist.therapistType.name ?? "",
                    style: Theme.of(context).textTheme.subtitle2,
                    overflow: TextOverflow.clip,
                  ),
                  Visibility(
                    visible: therapist.medicalCouncil != null ,
                    child: Text(
                      therapist.medicalCouncil ?? "",
                      style: Theme.of(context).textTheme.caption,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              Spacer(),
              VerticalDivider(
                thickness: 1.0,
                width: 24.0,
                indent: 4.0,
                endIndent: 4.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.purple.shade50),
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        therapist.totalExperience.toString(),
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.purple, fontWeight: FontWeight.w700),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Text(
                      "years",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontStyle: FontStyle.italic),
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      "exp",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontStyle: FontStyle.italic),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
