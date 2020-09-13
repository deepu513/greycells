import 'dart:async';
import 'dart:convert';

import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/extensions.dart';
import 'package:greycells/models/server_file/server_file.dart';
import 'package:greycells/networking/http_exceptions.dart';
import 'package:greycells/networking/request.dart';
import 'package:greycells/networking/response.dart';
import 'package:greycells/networking/serializable.dart';
import 'package:greycells/repository/settings_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

typedef SessionExpiredCallback = void Function();

class HttpService {
  static HttpService _instance;
  SettingsRepository _settingsRepository;

  HttpService._internal() {
    SettingsRepository.getInstance().then((value) {
      _settingsRepository = value;
    });
  }

  factory HttpService() {
    _instance ??= HttpService._internal();
    return _instance;
  }

  Future<Response<ResponseType>> postRaw<RequestType, ResponseType>(
      Request<RequestType> request,
      Serializable<ResponseType> responseSerializable) {
    print(request.toJsonString());
    return http
        .post(request.url,
            body: request.toJsonString(),
            headers: request.headers ?? _getDefaultHeaders(url: request.url))
        .then((http.Response value) =>
            _processResponse(value, responseSerializable))
        .catchError((e, stackTrace) => _handleError(e, stackTrace));
  }

  Future<ResponseType> post<RequestType, ResponseType>(
      Request<RequestType> request,
      Serializable<ResponseType> responseSerializable) {
    print(request.toJsonString());
    return http
        .post(request.url,
            body: request.toJsonString(),
            headers: request.headers ?? _getDefaultHeaders(url: request.url))
        .then((http.Response value) =>
            _processResponse(value, responseSerializable).getResponseBody())
        .catchError((e, stackTrace) => _handleError(e, stackTrace));
  }

  Future<ResponseType> get<RequestType, ResponseType>(
      Request<RequestType> request,
      Serializable<ResponseType> responseSerializable) {
    return http
        .get(request.url,
            headers: request.headers ?? _getDefaultHeaders(url: request.url))
        .then((http.Response value) =>
            _processResponse(value, responseSerializable).getResponseBody())
        .catchError((e, stackTrace) => _handleError(e, stackTrace));
  }

  Future<List<ResponseType>> getAll<RequestType, ResponseType>(
      Request<RequestType> request,
      Serializable<ResponseType> responseSerializable) {
    return http
        .get(request.url,
            headers: request.headers ?? _getDefaultHeaders(url: request.url))
        .then((http.Response value) =>
            _processResponse(value, responseSerializable)
                .getResponseBodyAsList())
        .catchError((e, stackTrace) => _handleError(e, stackTrace));
  }

  Future<ResponseType> put<RequestType, ResponseType>(
      Request<RequestType> request,
      Serializable<ResponseType> responseSerializable) {
    return http
        .put(request.url,
            body: request.toJsonString(),
            headers: request.headers ?? _getDefaultHeaders(url: request.url))
        .then((http.Response value) =>
            _processResponse(value, responseSerializable).getResponseBody())
        .catchError((e, stackTrace) => _handleError(e, stackTrace));
  }

  Future<ServerFile> multipart(String url, String filePath) async {
    try {
      final fileExtension = extension(filePath);

      final mediaType = fileExtension == ".pdf"
          ? MediaType('application', 'pdf')
          : MediaType('image', '*');

      final fileType = fileExtension == ".pdf" ? "pdf" : "image";

      final request = http.MultipartRequest("POST", Uri.parse(url))
        ..fields['Type'] = fileType
        ..files.add(await http.MultipartFile.fromPath("File", filePath,
            contentType: mediaType));
      request.headers.putIfAbsent(
          "Authorization",
          () =>
              "Bearer ${_settingsRepository.get(SettingKey.KEY_REQUEST_TOKEN)}");
      var response = await request.send();

      if (_isSuccessOrThrow(response.statusCode)) {
        final String responseString = await response.stream.bytesToString();
        if (responseString.isNullOrEmpty()) {
          throw UnknownException();
        } else {
          final responseJson = jsonDecode(responseString);
          return ServerFile.fromJson(responseJson);
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<bool> delete<RequestType>(Request<RequestType> request) {
    return http
        .delete(request.url,
            headers: request.headers ?? _getDefaultHeaders(url: request.url))
        .then((value) => value.statusCode == 200)
        .catchError((e, stackTrace) => _handleError(e, stackTrace));
  }

  Response<ResponseType> _processResponse<ResponseType>(
      http.Response actualResponse,
      Serializable<ResponseType> responseSerializable) {
    if (_isSuccessOrThrow(actualResponse.statusCode)) {
      if (responseSerializable == null) {
        return Response(null, null, statusCode: actualResponse.statusCode);
      } else
        return Response<ResponseType>(actualResponse.body, responseSerializable,
            statusCode: actualResponse.statusCode);
    } else
      throw UnknownException();
  }

  void _handleError(e, stackTrace) {
    print(e);
    print(stackTrace.toString());
    throw e;
  }

  bool _isSuccessOrThrow(int statusCode) {
    switch (statusCode) {
      case 200:
      case 201:
        return true;
      case 400:
        throw BadRequestException();
      case 401:
        throw UnauthorisedException();
      case 404:
        throw ResourceNotFoundException();
      case 409:
        throw ResourceConflictException();
      case 500:
      default:
        throw UnknownException();
    }
  }

  Map<String, String> _getDefaultHeaders({String url}) {
    var map = {"content-type": "application/json"};
    var token = _settingsRepository.get(SettingKey.KEY_REQUEST_TOKEN,
        defaultValue: "");

    if (!url.contains("authenticate") &&
        !url.contains("register") &&
        token != null &&
        token.isNotEmpty) {
      map.putIfAbsent("Authorization", () => "Bearer $token");
    }

    return map;
  }
}
