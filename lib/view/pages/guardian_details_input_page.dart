import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

class GuardianDetailsInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        Strings.guardianDetails,
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
      ),
    );
  }
}
