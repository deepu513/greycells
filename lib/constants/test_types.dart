class TestTypes {
  final String _value;
  final int _intValue;

  const TestTypes._internal(this._value, this._intValue);

  toString() => _value;

  intValue() => _intValue;

  static const BEHAVIOUR = const TestTypes._internal("Behaviour", 1);
  static const PERSONALITY = const TestTypes._internal("Personality", 2);

  static List<TestTypes> values() => [BEHAVIOUR, PERSONALITY];
}
