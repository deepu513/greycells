import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable(explicitToJson: true)
class Report {
  int patientId;

  int assessmentId;

  @JsonKey(name: "filePath")
  String fileName;

  int id;

  String createdDate;

  Report();

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
