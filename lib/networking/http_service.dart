import 'dart:async';

import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/models/token/token.dart';
import 'package:greycells/models/token/token_serializable.dart';
import 'package:greycells/networking/http_exceptions.dart';
import 'package:greycells/networking/interceptor.dart';
import 'package:greycells/networking/method.dart';
import 'package:greycells/networking/real_interceptor_chain.dart';
import 'package:greycells/networking/request.dart';
import 'package:greycells/networking/response.dart';
import 'package:greycells/networking/serializable.dart';
import 'package:greycells/networking/server_call_interceptor.dart';
import 'package:greycells/repository/settings/settings_repository.dart';

typedef SessionExpiredCallback = void Function();

class HttpService {
  static HttpService _instance;

  List<Interceptor> _interceptors;

  RealInterceptorChain _realInterceptorChain;

  SessionExpiredCallback _onSessionExpired;

  int _refreshTokenCounter = 0;

  HttpService._internal(
      List<Interceptor> interceptors, SessionExpiredCallback onSessionExpired) {
    _interceptors = interceptors != null ? interceptors : List<Interceptor>();

    // This will be called to log user out of the application
    _onSessionExpired = onSessionExpired;

    // Add real call interceptor
    _interceptors.add(ServerCallInterceptor());

    // This chain iterates through all interceptors and finally makes API call.
    _realInterceptorChain = RealInterceptorChain(_interceptors);
  }

  static HttpService get instance => _instance;

  factory HttpService(
      List<Interceptor> interceptors, SessionExpiredCallback onSessionExpired) {
    _instance ??= HttpService._internal(interceptors, onSessionExpired);
    return _instance;
  }

  Future<Response<ResponseType>> enqueue<RequestType, ResponseType>(
      Request<RequestType> request,
      Serializable<ResponseType> serializable) async {
    try {
      if (request != null)
        return _realInterceptorChain.proceed(request, serializable);
      else
        throw Exception("Request can not be null");
    } on UnauthorisedException {
      // Chain is broken here
      try {
        /** If you again get 401 in refreshing token call,
         *  this will go in endless loop
         *  It is mostly backend error but should at least be handled on frontend.
         *  Make a counter, initialize it to 0, increment it during refresh token,
         *  if counter > 0, logout user. */
        if (_refreshTokenCounter == 0) {
          _refreshTokenCounter++;

          // Get a refresh token request
          TokenSerializable tokenSerializable = TokenSerializable();

          // TODO: Replace with actual URL
          Request<Token> refreshTokenRequest =
              Request(Method.GET, "refreshTokenUrl", tokenSerializable);

          // await for the request to complete
          Response<Token> tokenResponse = await enqueue<Token, Token>(
              refreshTokenRequest, tokenSerializable);

          // update shared preferences with new token
          var updatedToken = tokenResponse.getResponseBody().token;

          await SettingsRepository.getInstance()
              .then((instance) => instance.saveValue(
                  SettingKey.KEY_REQUEST_TOKEN, updatedToken))
              .catchError(() {
            _onSessionExpired?.call();
            throw Exception("Session expired");
          });

          // call and enqueue again with same request
          return enqueue(request, serializable);
        } else {
          // Logout user
          _onSessionExpired?.call();
          throw Exception("Session expired");
        }
      } catch (e) {
        // If you get any error in refresh token, logout user from the app
        _onSessionExpired?.call();
        throw Exception("Session expired");
      } finally {
        _refreshTokenCounter = 0;
      }
    } catch (e) {
      throw e;
    } finally {
      _refreshTokenCounter = 0;
    }
  }
}
