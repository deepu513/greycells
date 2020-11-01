part of 'therapist_bloc.dart';

abstract class TherapistState extends Equatable {
  const TherapistState();

  @override
  List<Object> get props => [];
}

class TherapistInitial extends TherapistState {}

class TherapistsLoading extends TherapistState {}

class TherapistsLoaded extends TherapistState {
  final List<Therapist> therapists;
  TherapistsLoaded(this.therapists);
}

class TherapistsLoadError extends TherapistState {
  final String error;
  TherapistsLoadError(this.error);
}
