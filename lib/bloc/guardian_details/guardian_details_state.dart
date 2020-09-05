part of 'guardian_details_bloc.dart';

@immutable
abstract class GuardianDetailsState {}

class GuardianDetailsInitial extends GuardianDetailsState {}

class RelationshipUpdated extends GuardianDetailsState {
  final Relationship relationship;

  RelationshipUpdated(this.relationship);
}
