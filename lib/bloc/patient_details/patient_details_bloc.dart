import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/constants/gender.dart';
import 'package:greycells/constants/relationship.dart';
import 'package:greycells/models/patient/address/address.dart';
import 'package:greycells/models/patient/guardian/guardian.dart';
import 'package:greycells/models/patient/health/health_record.dart';
import 'package:greycells/models/patient/medical/medical_record.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:meta/meta.dart';

part 'patient_details_event.dart';

part 'patient_details_state.dart';

class PatientDetailsBloc
    extends Bloc<PatientDetailsEvent, PatientDetailsState> {
  Patient patient;

  PatientDetailsBloc() : super(PatientDetailsInitial()) {
    patient = Patient()..gender = Gender.MALE;

    /// Initialize address
    patient.address = Address();

    /// Initialize MedicalRecord
    patient.medicalRecord = MedicalRecord();

    /// Initialize Guardian with a default relationship
    patient.guardian = Guardian()..relationShip = Relationship.father;

    /// Initialize HealthRecord with a default values
    /// TODO: Also add default BMI
    patient.healthRecord = HealthRecord()
      ..weightInKg = 70
      ..heightInCm = 150;
  }

  @override
  Stream<PatientDetailsState> mapEventToState(
    PatientDetailsEvent event,
  ) async* {
    if (event is UpdateGuardianRelationship) {
      patient.guardian.relationShip = event.relationship;
      if (event.relationship != Relationship.other)
        patient.guardian.readableRelationship = event.relationship.toString();
      else
        patient.guardian.readableRelationship = event.actualValue;
      yield GuardianRelationshipUpdated(event.relationship);
    }

    if (event is UpdateGender) {
      patient.gender = event.gender;
      patient.genderValue = event.gender.intValue();
      patient.readableGender = event.gender.toString();
      yield GenderUpdated(event.gender);
    }
  }
}
