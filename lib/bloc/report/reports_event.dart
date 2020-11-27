part of 'reports_bloc.dart';

abstract class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object> get props => [];
}

class LoadAllReports extends ReportsEvent {}

class LoadReportsForPatient extends ReportsEvent {
  final int patientId;

  LoadReportsForPatient(this.patientId);
}

class DownloadReport extends ReportsEvent {
  final String fileName;

  DownloadReport(this.fileName);
}
