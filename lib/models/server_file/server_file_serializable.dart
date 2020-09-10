import 'package:greycells/models/server_file/server_file.dart';
import 'package:greycells/networking/serializable.dart';

class ServerFileSerializable implements Serializable<ServerFile> {
  @override
  ServerFile fromJson(Map<String, dynamic> json) {
    return ServerFile.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ServerFile serverFile) {
    return serverFile.toJson();
  }

  @override
  List<ServerFile> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((serverFileMap) =>
            serverFileMap == null ? null : fromJson(serverFileMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<ServerFile> serverFileList) {
    return serverFileList?.map((serverFile) => serverFile?.toJson())?.toList();
  }
}
