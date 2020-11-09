class SettingKey {
  final String _value;

  const SettingKey._internal(this._value);

  toString() => _value;

  static const KEY_IS_LOGGED_IN = const SettingKey._internal("is_logged_in");
  static const KEY_USER_ID = const SettingKey._internal("user_id");
  static const KEY_PATIENT_ID = const SettingKey._internal("patient_id");
  static const KEY_USERNAME = const SettingKey._internal("username");
  static const KEY_USERTYPE = const SettingKey._internal("usertype");
  static const KEY_USER_FIRST_NAME = const SettingKey._internal("first_name");
  static const KEY_USER_MOBILE = const SettingKey._internal("mobile_number");
  static const KEY_REQUEST_TOKEN = const SettingKey._internal("request_token");
  static const KEY_REFRESH_TOKEN = const SettingKey._internal("refresh_token");
  static const KEY_FCM_TOKEN = const SettingKey._internal("fcm_token");
}
