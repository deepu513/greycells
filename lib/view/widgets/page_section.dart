import 'package:flutter/material.dart';

class PageSection extends StatelessWidget {
  final Color textColor;
  final Widget icon;
  final String title;
  final String description;

  PageSection(
      {@required this.textColor,
      @required this.icon,
      @required this.title,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), child: icon),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: textColor, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 4.0,
              ),
              SelectableText(description,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontStyle: FontStyle.italic,
                        color: textColor,
                      ))
            ],
          ),
        ),
      ],
    );
  }
}
