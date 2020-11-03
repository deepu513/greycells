part of 'timeslot_bloc.dart';

abstract class TimeslotEvent extends Equatable {
  const TimeslotEvent();

  @override
  List<Object> get props => [];
}

class LoadTimeslotsForTherapist extends TimeslotEvent {
  final int therapistId;
  final String selectedDate;

  LoadTimeslotsForTherapist(this.therapistId, this.selectedDate);
}
