part of 'health_details_bloc.dart';

@immutable
abstract class HealthDetailsEvent {}

class UpdateGender extends HealthDetailsEvent {
  final Gender gender;

  UpdateGender(this.gender);
}
