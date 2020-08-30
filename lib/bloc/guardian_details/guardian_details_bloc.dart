import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mental_health/constants/relationship.dart';
import 'package:mental_health/models/guardian_details/guardian_details.dart';
import 'package:meta/meta.dart';

part 'guardian_details_event.dart';
part 'guardian_details_state.dart';

class GuardianDetailsBloc
    extends Bloc<GuardianDetailsEvent, GuardianDetailsState> {
  GuardianDetails guardianDetails;

  GuardianDetailsBloc() : super(GuardianDetailsInitial()) {
    // Initial values
    guardianDetails = GuardianDetails()..relationShip = Relationship.father;
  }

  @override
  Stream<GuardianDetailsState> mapEventToState(
    GuardianDetailsEvent event,
  ) async* {
    if (event is UpdateRelationship) {
      guardianDetails.relationShip = event.relationship;
      if (event.relationship != Relationship.other)
        guardianDetails.readableRelationship = event.relationship.toString();
      else
        guardianDetails.readableRelationship = event.actualValue;
      yield RelationshipUpdated(event.relationship);
    }

    if (event is UpdateMobileNumber) {
      guardianDetails.mobileNumber = event.mobileNumber;
      yield MobileNumberUpdated(event.mobileNumber);
    }
  }
}
