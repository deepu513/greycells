import 'package:flutter/material.dart';
import 'package:greycells/extensions.dart';

class CircleAvatarOrInitials extends StatelessWidget {
  final double radius;
  final String imageUrl;
  final String stringForInitials;

  const CircleAvatarOrInitials(
      {Key key, @required this.radius, this.imageUrl, this.stringForInitials})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
      child: imageUrl.isNullOrEmpty()
          ? Text(
              stringForInitials.initials(),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.white),
            )
          : null,
      radius: radius,
    );
  }
}
