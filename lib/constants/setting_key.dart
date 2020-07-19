class SettingKey {
  final String _value;

  const SettingKey._internal(this._value);

  toString() => _value;

  static const KEY_IS_LOGGED_IN = const SettingKey._internal("is_logged_in");
  static const KEY_USER_ID = const SettingKey._internal("user_id");
}
