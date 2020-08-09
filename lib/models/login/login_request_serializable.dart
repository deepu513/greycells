import 'package:mental_health/models/login/login_request.dart';
import 'package:mental_health/networking/serializable.dart';

class LoginRequestSerializable implements Serializable<LoginRequest> {
  @override
  LoginRequest fromJson(Map<String, dynamic> json) {
    return LoginRequest.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(LoginRequest loginRequest) {
    return loginRequest.toJson();
  }

  @override
  List<LoginRequest> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((loginRequestMap) =>
            loginRequestMap == null ? null : fromJson(loginRequestMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<LoginRequest> loginRequestList) {
    return loginRequestList
        ?.map((loginRequest) => loginRequest?.toJson())
        ?.toList();
  }
}
