import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/bloc/picker/file_picker_bloc.dart';
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
      patient.isMinor = calculateAge(DateTime(int.parse(patient.yearPart),
              int.parse(patient.monthPart), int.parse(patient.dayPart))) <
          18;

      if (!patient.isMinor) patient.guardian = null;
      yield StateOK();
    }

    if (event is HealthDetailsSubmitted) {
      final heightInMetres = patient.healthRecord.heightInCm / 100;
      patient.healthRecord.bmi =
          patient.healthRecord.weightInKg ~/ (heightInMetres * heightInMetres);
    }

    if (event is AddressValidated) {
      patient.address.readableAddress =
          patient.address.houseNumber + " " + patient.address.roadName;

      if (patient.isMinor)
        patient.guardian.address.readableAddress =
            patient.guardian.address.houseNumber +
                " " +
                patient.guardian.address.roadName;
      yield StateOK();
    }

    if (event is GuardianHasSameAddress) {
      patient.guardian.address.houseNumber = patient.address.houseNumber;
      patient.guardian.address.roadName = patient.address.roadName;
      patient.guardian.address.city = patient.address.city;
      patient.guardian.address.state = patient.address.state;
      patient.guardian.address.country = patient.address.country;
      patient.guardian.address.pincode = patient.address.pincode;
      yield GuardianAddressUpdated(true);
    }

    if (event is GuardianNotHasSameAddress) {
      yield GuardianAddressUpdated(false);
    }

    if (event is AddMedicalRecordFile) {
      patient.medicalRecord.pickedFiles.add(event.pickedFile);
      yield StateOK();
    }

    if (event is RemoveMedicalRecordFile) {
      patient.medicalRecord.pickedFiles.removeWhere((pickedFile) {
        return pickedFile.selectedFile.path ==
            event.pickedFile.selectedFile.path;
      });
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

  /// Not tested
  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}
