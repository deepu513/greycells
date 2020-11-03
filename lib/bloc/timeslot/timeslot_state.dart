part of 'timeslot_bloc.dart';

abstract class TimeslotState extends Equatable {
  const TimeslotState();

  @override
  List<Object> get props => [];
}

class TimeslotInitial extends TimeslotState {}

class TimeslotsLoading extends TimeslotState {}

class TimeslotsLoaded extends TimeslotState {
  final List<Timeslot> availableTimeslots;
  TimeslotsLoaded(this.availableTimeslots);
}

class TimeslotsEmpty extends TimeslotState {}

class TimeslotLoadError extends TimeslotState {
  final String error;
  TimeslotLoadError(this.error);
}
