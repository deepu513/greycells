import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/constants/gender.dart';
import 'package:greycells/models/health_details/health_details.dart';
import 'package:meta/meta.dart';

part 'health_details_event.dart';
part 'health_details_state.dart';

class HealthDetailsBloc extends Bloc<HealthDetailsEvent, HealthDetailsState> {
  HealthDetails healthDetails;

  HealthDetailsBloc() : super(HealthDetailsInitial()) {
    // Initialize with default values
    healthDetails = HealthDetails()
      ..gender = Gender.MALE
      ..weightInKg = 70
      ..heightInCm = 150;
  }

  @override
  Stream<HealthDetailsState> mapEventToState(
    HealthDetailsEvent event,
  ) async* {
    if (event is UpdateGender) {
      healthDetails.gender = event.gender;
      healthDetails.readableGender = event.gender.toString();
      yield GenderUpdated(event.gender);
    }
  }
}
