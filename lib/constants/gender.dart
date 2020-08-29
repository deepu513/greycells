class Gender {
  final String _value;

  const Gender._internal(this._value);

  toString() => _value;

  static const MALE = const Gender._internal("Male");
  static const FEMALE = const Gender._internal("Female");

  static List<Gender> values() => [MALE, FEMALE];
}