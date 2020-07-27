import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

class MedicalRecordsInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        Strings.medicalRecords,
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
      ),
    );
  }
}
