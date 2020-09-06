import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:meta/meta.dart';

part 'patient_details_event.dart';

part 'patient_details_state.dart';

class PatientDetailsBloc
    extends Bloc<PatientDetailsEvent, PatientDetailsState> {
  Patient _patientDetails;

  PatientDetailsBloc() : super(PatientDetailsInitial()) {
    _patientDetails = Patient();
  }

  @override
  Stream<PatientDetailsState> mapEventToState(
    PatientDetailsEvent event,
  ) async* {

  }
}
