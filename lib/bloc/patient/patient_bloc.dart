import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/repository/user_repository.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  UserRepository _userRepository;

  PatientBloc() : super(PatientInitial()) {
    _userRepository = UserRepository();
  }

  @override
  Stream<PatientState> mapEventToState(PatientEvent event) async* {
    if (event is LoadPatients) {
      yield Loading();
      try {
        List<Patient> patients = await _userRepository.getAllPatients();
        if (patients != null) {
          if (patients.isEmpty)
            yield Empty();
          else {
            yield Loaded(patients);
          }
        } else
          yield Error(ErrorMessages.GENERIC_ERROR_MESSAGE);
      } catch (e) {
        debugPrint(e.toString());
        yield Error(ErrorMessages.GENERIC_ERROR_MESSAGE);
      }
    }
  }
}
