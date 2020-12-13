part of 'therapist_type_bloc.dart';

abstract class TherapistTypeState extends Equatable {
  const TherapistTypeState();

  @override
  List<Object> get props => [];
}

class TherapistTypeInitial extends TherapistTypeState {}

class TherapistTypesLoading extends TherapistTypeState {}

class TherapistTypesLoaded extends TherapistTypeState {
  final List<TherapistType> therapistTypes;

  TherapistTypesLoaded(this.therapistTypes);
}

class TherapistTypesError extends TherapistTypeState {}

class TherapistTypesEmpty extends TherapistTypeState {}
