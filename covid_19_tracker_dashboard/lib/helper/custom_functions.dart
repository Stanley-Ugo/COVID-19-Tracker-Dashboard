import 'package:intl/intl.dart';

class CustomFunctions {
  static String reduceString(String input, int maxLength,
      {bool addEllipsis = true}) {
    if (input.length <= maxLength) return input;

    if (addEllipsis && maxLength > 3) {
      return '${input.substring(0, maxLength - 3)}...';
    }

    return input.substring(0, maxLength);
  }

  static String formatNumber(num value) {
    final formatter = NumberFormat('#,###');
    return formatter.format(value);
  }
}
