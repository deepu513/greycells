import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/constants/gender.dart';
import 'package:greycells/constants/relationship.dart';
import 'package:greycells/models/patient/address/address.dart';
import 'package:greycells/models/patient/guardian/guardian.dart';
import 'package:greycells/models/patient/health/health_record.dart';
import 'package:greycells/models/patient/medical/medical_record.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:intl/intl.dart';
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

    if (event is BirthDetailsValidated) {
      patient.dateOfBirth = getStringDateTime(
          patient.dayPart, patient.monthPart, patient.yearPart);
      patient.timeOfBirth = getStringDateTime(
          patient.dayPart,
          patient.monthPart,
          patient.yearPart,
          patient.hourPart,
          patient.minutePart,
          true);
      yield StateOK();
    }
  }

  String getStringDateTime(String dayPart, String monthPart, String yearPart,
      [String hourPart = "00",
      String minutePart = "00",
      bool onlyTime = false]) {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy hh:mm");
    DateTime serverDateTime = dateFormat
        .parseStrict('$dayPart/$monthPart/$yearPart $hourPart:$minutePart');

    if (onlyTime) {
      DateFormat convertedFormat = DateFormat("hh:mm a");
      return convertedFormat.format(serverDateTime);
    }

    DateFormat convertedFormat = DateFormat("dd/MM/yyyy");
    return convertedFormat.format(serverDateTime);
  }
}
