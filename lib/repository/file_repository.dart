import 'package:greycells/flavor_config.dart';
import 'package:greycells/models/server_file/server_file.dart';
import 'package:greycells/networking/http_service.dart';

class FileRepository {
  HttpService _httpService;

  FileRepository() {
    _httpService = HttpService();
  }

  Future<ServerFile> upload(String filePath) {
    final url = "${FlavorConfig.getBaseUrl()}File";
    return _httpService.multipart(url, filePath);
  }
}