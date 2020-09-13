class SettingKey {
  final String _value;

  const SettingKey._internal(this._value);

  toString() => _value;

  static const KEY_IS_LOGGED_IN = const SettingKey._internal("is_logged_in");
  static const KEY_USER_ID = const SettingKey._internal("user_id");
  static const KEY_PATIENT_ID = const SettingKey._internal("patient_id");
  static const KEY_USERNAME = const SettingKey._internal("username");
  static const KEY_USER_FIRST_NAME = const SettingKey._internal("first_name");
  static const KEY_USER_MOBILE = const SettingKey._internal("mobile_number");
  static const KEY_REQUEST_TOKEN = const SettingKey._internal("request_token");
  static const KEY_REFRESH_TOKEN = const SettingKey._internal("refresh_token");
  static const KEY_PATIENT_DETAIL_SUBMITTED =
      const SettingKey._internal("patient_detail_submitted");
  static const KEY_FIRST_TEST_DONE = const SettingKey._internal("first_test_done");
  static const KEY_SECOND_TEST_DONE = const SettingKey._internal("second_test_done");
  static const KEY_CURRENT_QUESTION = SettingKey._internal("current_question");
}
