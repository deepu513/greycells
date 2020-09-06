import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/constants/relationship.dart';
import 'package:greycells/models/guardian_details/guardian.dart';
import 'package:meta/meta.dart';

part 'guardian_details_event.dart';
part 'guardian_details_state.dart';

class GuardianDetailsBloc
    extends Bloc<GuardianDetailsEvent, GuardianDetailsState> {
  Guardian guardianDetails;

  GuardianDetailsBloc() : super(GuardianDetailsInitial()) {
    // Initial values
    guardianDetails = Guardian()..relationShip = Relationship.father;
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
  }
}
