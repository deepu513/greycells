import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greycells/extensions.dart';

class EmptyState extends StatelessWidget {
  final String svgImageName;
  final String title;
  final String description;

  const EmptyState({Key key, this.svgImageName, this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgImageName.isNullOrEmpty()
                ? "images/trekking.svg"
                : "images/$svgImageName",
                height: 280.0,
          ),
          Text(title.isNullOrEmpty() ? "We couldn't find anything!" : title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          SizedBox(
            height: 16.0,
          ),
          Text(
              description.isNullOrEmpty() ? "Try exploring more." : description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  height: 1.3,
                  letterSpacing: 0.5,
                  wordSpacing: 0.7,
                  color: Colors.grey)),
        ],
      ),
    );
  }
}
