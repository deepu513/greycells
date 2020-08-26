import 'package:mental_health/constants/strings.dart';

class ValidationField {
  final String _value;

  const ValidationField._internal(this._value);

  errorMessage() => _value;

  static const NONE = ValidationField._internal(null);

  static const FIRST_NAME =
      ValidationField._internal(ErrorMessages.FIRST_NAME_ERROR_MESSAGE);

  static const LAST_NAME =
      ValidationField._internal(ErrorMessages.LAST_NAME_ERROR_MESSAGE);

  static const PASSWORD =
      ValidationField._internal(ErrorMessages.PASSWORD_ERROR_MESSAGE);

  static const CONFIRM_PASSWORD =
      ValidationField._internal(ErrorMessages.CONFIRM_PASSWORD_ERROR_MESSAGE);

  static const CONTACT_NUMBER =
      ValidationField._internal(ErrorMessages.MOBILE_ERROR_MESSAGE);

  static const EMAIL =
      ValidationField._internal(ErrorMessages.EMAIL_ERROR_MESSAGE);

  static const HOUSE_NUMBER =
      ValidationField._internal(ErrorMessages.HOUSE_NUMBER_ERROR_MESSAGE);

  static const ROAD_NAME =
      ValidationField._internal(ErrorMessages.ROAD_NAME_ERROR_MESSAGE);

  static const CITY =
      ValidationField._internal(ErrorMessages.CITY_ERROR_MESSAGE);

  static const STATE =
      ValidationField._internal(ErrorMessages.STATE_ERROR_MESSAGE);

  static const COUNTRY =
      ValidationField._internal(ErrorMessages.COUNTRY_ERROR_MESSAGE);

  static const PINCODE =
      ValidationField._internal(ErrorMessages.PINCODE_ERROR_MESSAGE);

  static const PLACE_PART =
      ValidationField._internal(ErrorMessages.PLACE_PART_ERROR_MESSAGE);

  static const DATE_PART =
      ValidationField._internal(ErrorMessages.DATE_PART_ERROR_MESSAGE);

  static const TIME_PART =
      ValidationField._internal(ErrorMessages.TIME_PART_ERROR_MESSAGE);
}
