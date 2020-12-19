import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:greycells/bloc/picker/file_picker_bloc.dart';
import 'package:greycells/constants/gender.dart';
import 'package:greycells/constants/relationship.dart';
import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/address/address.dart';
import 'package:greycells/models/patient/medical/medical_record.dart';
import 'package:greycells/models/patient/patient.dart';
import 'package:greycells/repository/file_repository.dart';
import 'package:greycells/repository/settings_repository.dart';
import 'package:greycells/repository/user_repository.dart';
import 'package:greycells/extensions.dart';

part 'patient_details_edit_event.dart';
part 'patient_details_edit_state.dart';

class PatientDetailsEditBloc
    extends Bloc<PatientDetailsEditEvent, PatientDetailsEditState> {
  Patient patient;

  UserRepository _userRepository;
  FileRepository _fileRepository;
  SettingsRepository _settingsRepository;

  PatientDetailsEditBloc(this.patient) : super(PatientDetailsEditInitial()) {
    _userRepository = UserRepository();
    _fileRepository = FileRepository();

    patient.address.houseNumber =
        patient.address.readableAddress.split(",")[0].trim();
    patient.address.roadName =
        patient.address.readableAddress.split(",")[1].trim();

    if (patient.guardian.address != null) {
      patient.guardian.address.houseNumber =
          patient.guardian.address.readableAddress.split(",")[0].trim();
      patient.guardian.address.roadName =
          patient.guardian.address.readableAddress.split(",")[1].trim();
    }

    if (patient.guardian.address == null) {
      patient.guardian.address = Address();
    }

    SettingsRepository.getInstance().then((value) {
      _settingsRepository = value;
      patient.customerId = value.get(SettingKey.KEY_USER_ID);
    });
  }

  @override
  Stream<PatientDetailsEditState> mapEventToState(
    PatientDetailsEditEvent event,
  ) async* {
    if (event is UpdateGuardianRelationship) {
      patient.guardian.relationShip = event.relationship;
      if (event.relationship != Relationship.other)
        patient.guardian.readableRelationship = event.relationship.toString();
      else if (event.relationship == Relationship.other) {
        patient.guardian.readableRelationship = "";
        yield OtherRelationshipSelected();
      }
      yield StateOK();
    }

    if (event is UpdateGender) {
      patient.gender = event.gender;
      patient.genderValue = event.gender.intValue();
      patient.readableGender = event.gender.toString();
      yield GenderUpdated(event.gender);
    }

    if (event is HealthDetailsSubmitted) {
      final heightInMetres = patient.healthRecord.heightInCm / 100;
      patient.healthRecord.bmi =
          patient.healthRecord.weightInKg ~/ (heightInMetres * heightInMetres);
      yield StateOK();
    }

    if (event is AddressValidated) {
      patient.address.readableAddress = patient.address.houseNumber +
          ", " +
          patient.address.roadName +
          ", " +
          patient.address.city +
          ", " +
          patient.address.state +
          ", " +
          patient.address.country +
          " " +
          patient.address.pincode;

      patient.guardian.address.readableAddress =
          patient.guardian.address.houseNumber +
              ", " +
              patient.guardian.address.roadName +
              ", " +
              patient.guardian.address.city +
              ", " +
              patient.guardian.address.state +
              ", " +
              patient.guardian.address.country +
              " " +
              patient.guardian.address.pincode;

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
      patient.pickedFiles.add(event.pickedFile);
      yield StateOK();
    }

    if (event is RemoveMedicalRecordFile) {
      patient.pickedFiles.removeWhere((pickedFile) {
        return pickedFile.selectedFile.path ==
            event.pickedFile.selectedFile.path;
      });
      yield StateOK();
    }

    // if (event is UploadPatientDetails) {
    //   try {
    //     if (!patient.localProfilePicFilePath.isNullOrEmpty()) {
    //       yield PatientUploadProgress(Strings.uploadingProfilePicture);
    //       var profilePicServerFile =
    //           await _fileRepository.upload(patient.localProfilePicFilePath);
    //       patient.profilePicId = profilePicServerFile.fileId;
    //     }

    //     if (patient.pickedFiles.isNotEmpty && patient.medicalRecords.isEmpty) {
    //       yield PatientUploadProgress(Strings.uploadingMedicalRecord);
    //       var medicalRecordList = List<MedicalRecord>();
    //       for (var element in patient.pickedFiles) {
    //         var serverFile =
    //             await _fileRepository.upload(element.selectedFile.path);
    //         medicalRecordList.add(MedicalRecord()..fileId = serverFile.fileId);
    //       }
    //       patient.medicalRecords.addAll(medicalRecordList);
    //     }

    //     yield PatientUploadProgress(Strings.almostDone);

    //     UpdatePatientResponse patientResult =
    //         await _userRepository.updatePatientDetails(patient: patient);
    //     if (patientResult != null) {
    //       await _settingsRepository.saveValue(
    //           SettingKey.KEY_PATIENT_ID, patientResult.id);
    //       yield PatientDetailsUploaded(Strings.patientDetailsSaved);
    //     } else
    //       yield ErrorWhileUploading();
    //   } catch (error) {
    //     print(error);
    //     yield ErrorWhileUploading();
    //   }
    // }
  }
}
