import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/patient_details/patient_details_bloc.dart';

class PatientUploadPage extends StatefulWidget {
  const PatientUploadPage();

  @override
  _PatientUploadPageState createState() => _PatientUploadPageState();
}

class _PatientUploadPageState extends State<PatientUploadPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PatientDetailsBloc>(context).add(UploadPatientDetails());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientDetailsBloc, PatientDetailsState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          alignment: Alignment.center,
          child: Text(
            "Saving, please wait...",
            style: Theme.of(context).textTheme.headline5.copyWith(
              fontWeight: FontWeight.w300
            ),
          ),
        );
      },
    );
  }
}
