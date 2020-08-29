part of 'health_details_bloc.dart';

@immutable
abstract class HealthDetailsState {}

class HealthDetailsInitial extends HealthDetailsState {}

class GenderUpdated extends HealthDetailsState {
  final Gender updatedGender;

  GenderUpdated(this.updatedGender);
}
