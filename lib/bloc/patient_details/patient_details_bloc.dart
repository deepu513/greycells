import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/models/patient_details/patient_details.dart';
import 'package:meta/meta.dart';

part 'patient_details_event.dart';

part 'patient_details_state.dart';

class PatientDetailsBloc
    extends Bloc<PatientDetailsEvent, PatientDetailsState> {
  PatientDetails _patientDetails;

  PatientDetailsBloc() : super(PatientDetailsInitial()) {
    _patientDetails = PatientDetails();
  }

  @override
  Stream<PatientDetailsState> mapEventToState(
    PatientDetailsEvent event,
  ) async* {

  }
}
