class Utils {
  static bool isNullOrEmpty(String value) {
    if (value == null)
      return true;
    else if (value != null && value.trim().isEmpty)
      return true;
    else
      return false;
  }

  static bool hasRequiredLength(String value, int length) =>
      value != null && value.isNotEmpty && value.length == length;
}
