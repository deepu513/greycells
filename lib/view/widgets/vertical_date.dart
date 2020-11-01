import 'package:flutter/material.dart';

class VerticalDate extends StatelessWidget {
  final String dayOfWeek;
  final String dayofMonth;
  final String month;

  VerticalDate(this.dayOfWeek, this.dayofMonth, this.month);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          dayOfWeek.substring(0,2),
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.blueGrey, fontWeight: FontWeight.bold),
          overflow: TextOverflow.clip,
        ),
        Text(
          dayofMonth,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Color(0xFF100249), fontWeight: FontWeight.bold),
          overflow: TextOverflow.clip,
        ),
        Text(
          month.substring(0,2),
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.cyan, fontWeight: FontWeight.bold),
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }
}
