import 'package:greycells/networking/request.dart';
import 'package:greycells/networking/response.dart';
import 'package:greycells/networking/serializable.dart';

abstract class Interceptor {
  Future<Response<ResponseType>> intercept<RequestType, ResponseType>(
      Chain chain);
}

abstract class Chain {
  Request<RequestType> request<RequestType>();

  Future<Response<ResponseType>> proceed<RequestType, ResponseType>(
      Request<RequestType> request, Serializable<ResponseType> serializable);

  Serializable<ResponseType> responseSerializable<ResponseType>();
}
