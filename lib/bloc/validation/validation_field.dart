import 'package:greycells/constants/strings.dart';

class ValidationField {
  final String _value;
  final int id;

  const ValidationField._internal(this._value, this.id);

  errorMessage() => _value;

  static const NONE = ValidationField._internal(null, 0);

  static const FIRST_NAME =
      ValidationField._internal(ErrorMessages.FIRST_NAME_ERROR_MESSAGE, 1);

  static const LAST_NAME =
      ValidationField._internal(ErrorMessages.LAST_NAME_ERROR_MESSAGE, 2);

  static const PASSWORD =
      ValidationField._internal(ErrorMessages.PASSWORD_ERROR_MESSAGE, 3);

  static const CONFIRM_PASSWORD = ValidationField._internal(
      ErrorMessages.CONFIRM_PASSWORD_ERROR_MESSAGE, 4);

  static const CONTACT_NUMBER =
      ValidationField._internal(ErrorMessages.MOBILE_ERROR_MESSAGE, 5);

  static const EMAIL =
      ValidationField._internal(ErrorMessages.EMAIL_ERROR_MESSAGE, 6);

  static const HOUSE_NUMBER =
      ValidationField._internal(ErrorMessages.HOUSE_NUMBER_ERROR_MESSAGE, 7);

  static const ROAD_NAME =
      ValidationField._internal(ErrorMessages.ROAD_NAME_ERROR_MESSAGE, 8);

  static const CITY =
      ValidationField._internal(ErrorMessages.CITY_ERROR_MESSAGE, 9);

  static const STATE =
      ValidationField._internal(ErrorMessages.STATE_ERROR_MESSAGE, 10);

  static const COUNTRY =
      ValidationField._internal(ErrorMessages.COUNTRY_ERROR_MESSAGE, 11);

  static const PINCODE =
      ValidationField._internal(ErrorMessages.PINCODE_ERROR_MESSAGE, 12);

  static const GUARDIAN_HOUSE_NUMBER =
      ValidationField._internal(ErrorMessages.HOUSE_NUMBER_ERROR_MESSAGE, 13);

  static const GUARDIAN_ROAD_NAME =
      ValidationField._internal(ErrorMessages.ROAD_NAME_ERROR_MESSAGE, 14);

  static const GUARDIAN_CITY =
      ValidationField._internal(ErrorMessages.CITY_ERROR_MESSAGE, 15);

  static const GUARDIAN_STATE =
      ValidationField._internal(ErrorMessages.STATE_ERROR_MESSAGE, 16);

  static const GUARDIAN_COUNTRY =
      ValidationField._internal(ErrorMessages.COUNTRY_ERROR_MESSAGE, 17);

  static const GUARDIAN_PINCODE =
      ValidationField._internal(ErrorMessages.PINCODE_ERROR_MESSAGE, 18);

  static const PLACE_PART =
      ValidationField._internal(ErrorMessages.PLACE_PART_ERROR_MESSAGE, 19);

  static const DATE_PART =
      ValidationField._internal(ErrorMessages.DATE_PART_ERROR_MESSAGE, 20);

  static const TIME_PART =
      ValidationField._internal(ErrorMessages.TIME_PART_ERROR_MESSAGE, 21);

  static const OTHER_RELATION =
      ValidationField._internal(ErrorMessages.RELATION_ERROR_MESSAGE, 22);

  static const LENGTH =
      ValidationField._internal(ErrorMessages.MINIMUM_LENGTH_ERROR_MESSAGE, 23);
}
