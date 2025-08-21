abstract final class DataSerializer {
  static int? toInt(value) {
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  static double? toDouble(value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  static bool? toBool(value) {
    if (value is bool) {
      return value;
    }
    if (value is String) {
      return value == '1';
    }
    if (value is num) {
      return value == 1;
    }
    return null;
  }
}
