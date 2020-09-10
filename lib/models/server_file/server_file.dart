import 'package:json_annotation/json_annotation.dart';

part 'server_file.g.dart';

@JsonSerializable(explicitToJson: true)
class ServerFile {
  int fileId;
  String name;

  ServerFile();

  factory ServerFile.fromJson(Map<String, dynamic> json) =>
      _$ServerFileFromJson(json);

  Map<String, dynamic> toJson() => _$ServerFileToJson(this);
}
