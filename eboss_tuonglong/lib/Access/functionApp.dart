import 'package:intl/intl.dart';

class AppFormatter {
  static String formatCurrencyDo(double? value) {
    if (value == null) return '';
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '');
    return formatter.format(value);
  }
    static String formatCurrencyInt(int? value) {
    if (value == null) return '';
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '');
    return formatter.format(value);
  }
}