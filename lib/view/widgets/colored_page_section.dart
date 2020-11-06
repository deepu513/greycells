import 'package:flutter/material.dart';
import 'package:greycells/view/widgets/page_section.dart';

class ColoredPageSection extends StatelessWidget {
  final Color sectionColor;
  final Color textColor;
  final Widget icon;
  final String title;
  final String description;

  ColoredPageSection(
      {@required this.sectionColor,
      @required this.textColor,
      @required this.icon,
      @required this.title,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          shape: BoxShape.rectangle,
          color: sectionColor),
      padding: EdgeInsets.all(8.0),
      child: PageSection(
        textColor: textColor,
        icon: icon,
        title: title,
        description: description,
      ),
    );
  }
}
