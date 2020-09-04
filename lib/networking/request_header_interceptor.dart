import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/networking/interceptor.dart';
import 'package:greycells/networking/request.dart';
import 'package:greycells/networking/response.dart';
import 'package:greycells/repository/settings/settings_repository.dart';

class RequestHeaderInterceptor implements Interceptor {
  final SettingsRepository _settingsRepository;

  RequestHeaderInterceptor(this._settingsRepository)
      : assert(_settingsRepository != null);

  @override
  Future<Response<ResponseType>> intercept<RequestType, ResponseType>(
      Chain chain) {
    Request request = chain.request();

    if (request.headers == null) {
      Request newRequest = request.copyWith(
          headers: _getDefaultHeaders(token: _getToken(request.url)));
      return chain.proceed(newRequest, chain.responseSerializable());
    }

    return chain.proceed(request, chain.responseSerializable());
  }

  String _getToken(String url) {
    return url == "refreshTokenUrl"
        ? _settingsRepository.get(SettingKey.KEY_REFRESH_TOKEN)
        : _settingsRepository.get(SettingKey.KEY_REQUEST_TOKEN);
  }

  Map<String, String> _getDefaultHeaders({String token}) {
    var map = {"content-type": "application/json"};

    if (token != null && token.isNotEmpty) {
      map.putIfAbsent("Authorization", () => "Bearer $token");
    }

    return map;
  }
}
