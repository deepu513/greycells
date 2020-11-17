class Relationship {
  final String _displayText;

  const Relationship._internal(this._displayText);

  toString() => _displayText;

  static const father = Relationship._internal("Father");
  static const mother = Relationship._internal("Mother");
  static const brother = Relationship._internal("Brother");
  static const sister = Relationship._internal("Sister");
  static const spouse = Relationship._internal("Spouse");
  static const other = Relationship._internal("Other");

  static List<Relationship> values() =>
      [father, mother, brother, sister, other];
}
