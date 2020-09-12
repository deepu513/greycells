import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/patient_details/patient_details_bloc.dart';
import 'package:greycells/view/widgets/error_with_retry.dart';

class PatientUploadPage extends StatefulWidget {
  final VoidCallback onError;
  final VoidCallback onUploadStart;
  final VoidCallback onUploadComplete;

  PatientUploadPage(
      {@required this.onUploadStart,
      @required this.onUploadComplete,
      @required this.onError})
      : assert(onError != null),
        assert(onUploadStart != null),
        assert(onUploadComplete != null);

  @override
  _PatientUploadPageState createState() => _PatientUploadPageState();
}

class _PatientUploadPageState extends State<PatientUploadPage> {
  @override
  void initState() {
    super.initState();
    _uploadPatientDetails();
  }

  void _uploadPatientDetails() {
    widget.onUploadStart.call();
    BlocProvider.of<PatientDetailsBloc>(context).add(UploadPatientDetails());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientDetailsBloc, PatientDetailsState>(
      listener: (context, state) {
        if (state is ErrorWhileUploading) {
          widget.onError.call();
        }

        if(state is PatientDetailsUploaded) {
          widget.onUploadComplete.call();
        }
      },
      child: BlocBuilder<PatientDetailsBloc, PatientDetailsState>(
        builder: (context, state) {
          if (state is PatientUploadProgress)
            return _PatientUploadProgress(state.message);
          if (state is ErrorWhileUploading) {
            return ErrorWithRetry(
              onRetryPressed: _uploadPatientDetails,
            );
          } else
            return Container();
        },
      ),
    );
  }
}

class _PatientUploadProgress extends StatelessWidget {
  final String progressText;

  _PatientUploadProgress(this.progressText);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        progressText,
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontWeight: FontWeight.w300),
        overflow: TextOverflow.clip,
        textAlign: TextAlign.center,
      ),
    );
  }
}
