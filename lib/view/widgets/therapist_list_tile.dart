import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:greycells/models/therapist/therapist.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/view/widgets/circle_avatar_or_initials.dart';
import 'package:greycells/extensions.dart';

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
              CircleAvatarOrInitials(
                radius: 28.0,
                imageUrl: therapist.file != null
                    ? therapist.file.name.withBaseUrlForImage()
                    : "",
                stringForInitials: therapist.fullName,
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    therapist.fullName,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    therapist.therapistType.name ?? "",
                    style: Theme.of(context).textTheme.subtitle2,
                    overflow: TextOverflow.clip,
                  ),
                  Visibility(
                    visible: therapist.medicalCouncil != null,
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
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: 32.0, minWidth: 32.0),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple.shade50),
                        alignment: Alignment.center,
                        child: Text(
                          therapist.totalExperience.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontFeatures: [
                            FontFeature.tabularFigures(),
                          ], color: Colors.purple, fontWeight: FontWeight.w700),
                          overflow: TextOverflow.clip,
                        ),
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
