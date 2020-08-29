part of 'guardian_details_bloc.dart';

abstract class GuardianDetailsEvent {}

class UpdateRelationship extends GuardianDetailsEvent {
  final Relationship relationship;
  String actualValue;

  UpdateRelationship(this.relationship, {this.actualValue});
}

class UpdateMobileNumber extends GuardianDetailsEvent {
  final String mobileNumber;

  UpdateMobileNumber(this.mobileNumber);
}
