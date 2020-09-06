class Gender {
  final String _value;
  final int _intValue;

  const Gender._internal(this._value, this._intValue);

  toString() => _value;
  intValue() => _intValue;

  static const MALE = const Gender._internal("Male", 0);
  static const FEMALE = const Gender._internal("Female", 1);

  static List<Gender> values() => [MALE, FEMALE];
}
