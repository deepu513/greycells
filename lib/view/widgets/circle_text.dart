import 'package:flutter/material.dart';

class CircleText extends StatelessWidget {
  final Text text;
  final Color circleColor;
  final EdgeInsetsGeometry padding;

  CircleText(
      {@required this.text, @required this.circleColor, this.padding})
      : assert(text != null),
        assert(circleColor != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: circleColor,
        ),
        child: text);
  }
}