part of 'therapist_type_bloc.dart';

abstract class TherapistTypeEvent extends Equatable {
  const TherapistTypeEvent();

  @override
  List<Object> get props => [];
}

class LoadTherapistTypes extends TherapistTypeEvent {}
