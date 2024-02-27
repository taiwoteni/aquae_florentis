class NumberDecorator {
  static String toDecoratedString({required int number}) {
    final length = number.toString().length;
    String suffix = "";
    String prefix = number.toString();
    if (length > 3 && length < 7) {
      // In thousands..
      suffix = "K";
      final int rlength = length - 1;
      int divisor = 1;
      for (int i = 0; i < rlength && divisor <= 100; i++) {
        divisor *= 10;
      }

      final double decRem = number.toDouble() / divisor;
      if (!decRem.toStringAsFixed(1).endsWith("0")) {
        prefix = decRem.toStringAsFixed(1);
      } else {
        prefix = decRem.toStringAsFixed(0);
      }
      return "${prefix}K";
    }
    if (length > 6) {
      // In Millions..
      suffix = "M";
      final int rlength = length - 1;
      int divisor = 1;
      for (int i = 1; i <= rlength && divisor <= 100000; i++) {
        divisor *= 10;
      }

      final double decRem = number.toDouble() / divisor;
      if (!decRem.toStringAsFixed(1).endsWith("0")) {
        prefix = decRem.toStringAsFixed(1);
      } else {
        prefix = decRem.toStringAsFixed(0);
      }
      return "${prefix}M";
    }
    return prefix + suffix;
  }
}
