import 'package:flutter/material.dart';
import 'package:greycells/models/patient/patient.dart';

class PatientUploadPage extends StatefulWidget {

  const PatientUploadPage ();

  @override
  _PatientUploadPageState createState() => _PatientUploadPageState();
}

class _PatientUploadPageState extends State<PatientUploadPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("Uploading"),
    );
  }
}
