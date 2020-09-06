import 'dart:async';

import 'package:greycells/networking/http_exceptions.dart';
import 'package:greycells/networking/request.dart';
import 'package:greycells/networking/response.dart';
import 'package:greycells/networking/serializable.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

typedef SessionExpiredCallback = void Function();

class HttpService {
  static HttpService _instance;

  HttpService._internal();

  factory HttpService() {
    _instance ??= HttpService._internal();
    return _instance;
  }

  Future<Response<ResponseType>> postRaw<RequestType, ResponseType>(
      Request<RequestType> request,
      Serializable<ResponseType> responseSerializable) {
    return http
        .post(request.url,
            body: request.toJsonString(),
            headers: request.headers ?? _getDefaultHeaders())
        .then((http.Response value) =>
            _processResponse(value, responseSerializable))
        .catchError((e, stackTrace) => _handleError(e, stackTrace));
  }

  Future<ResponseType> post<RequestType, ResponseType>(
      Request<RequestType> request,
      Serializable<ResponseType> responseSerializable) {
    return http
        .post(request.url,
            body: request.toJsonString(),
            headers: request.headers ?? _getDefaultHeaders())
        .then((http.Response value) =>
            _processResponse(value, responseSerializable).getResponseBody())
        .catchError((e, stackTrace) => _handleError(e, stackTrace));
  }

  Future<ResponseType> get<RequestType, ResponseType>(
      Request<RequestType> request,
      Serializable<ResponseType> responseSerializable) {
    return http
        .get(request.url, headers: request.headers ?? _getDefaultHeaders())
        .then((http.Response value) =>
            _processResponse(value, responseSerializable).getResponseBody())
        .catchError((e, stackTrace) => _handleError(e, stackTrace));
  }

  Future<List<ResponseType>> getAll<RequestType, ResponseType>(
      Request<RequestType> request,
      Serializable<ResponseType> responseSerializable) {
    return http
        .get(request.url, headers: request.headers ?? _getDefaultHeaders())
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
            headers: request.headers ?? _getDefaultHeaders())
        .then((http.Response value) =>
            _processResponse(value, responseSerializable).getResponseBody())
        .catchError((e, stackTrace) => _handleError(e, stackTrace));
  }

  Future<bool> multipart(String url, String type, String filePath) async {
    final mediaType = extension(filePath) == ".pdf"
        ? MediaType('application', 'pdf')
        : MediaType('image', '*');

    final request = http.MultipartRequest("POST",  Uri.parse(url))
      ..fields['Type'] = type
      ..files.add(await http.MultipartFile.fromPath("File", filePath,
          contentType: mediaType));
    var response = await request.send();
    return response.statusCode == 200;
  }

  Future<bool> delete<RequestType>(Request<RequestType> request) {
    return http
        .delete(request.url, headers: request.headers ?? _getDefaultHeaders())
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
      throw UnknownResponseCodeException();
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
        throw UnknownResponseCodeException();
    }
  }

  Map<String, String> _getDefaultHeaders({String token}) {
    var map = {"content-type": "application/json"};

    if (token != null && token.isNotEmpty) {
      map.putIfAbsent("Authorization", () => "Bearer $token");
    }

    return map;
  }
}
