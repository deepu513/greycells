part of 'therapist_bloc.dart';

abstract class TherapistEvent extends Equatable {
  const TherapistEvent();

  @override
  List<Object> get props => [];
}

class LoadTherapists extends TherapistEvent {}

class LoadTherapistsWithType extends TherapistEvent {
  final TherapistType therapistType;

  LoadTherapistsWithType(this.therapistType);
}
