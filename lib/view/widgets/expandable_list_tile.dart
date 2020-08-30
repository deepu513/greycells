import 'package:flutter/material.dart';

class ExpandableListTile extends StatelessWidget {
  final Text title;
  final Text subtitle;
  final List<Widget> children;

  ExpandableListTile({this.title, this.subtitle, this.children});

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: EdgeInsets.all(0),
      child:
          ExpansionTile(title: title, subtitle: subtitle, children: children),
    );
  }
}
