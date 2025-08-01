import 'package:eboss_tuonglong/DatabaseHelper/mobilelanguageProvider.dart';
import 'package:eboss_tuonglong/model/SongNgu/mobileapplanguge.dart';
import 'package:intl/intl.dart';
import 'package:eboss_tuonglong/Access/keyservices.dart';
import 'package:eboss_tuonglong/Access/sharedpreferencesservice.dart';
import 'package:provider/provider.dart';

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


class SharedPreferencesService {
  static String? getString(String key) {
    return 'VI'; // Giả lập người dùng đã chọn tiếng Việt
  }
}

class KeyServices {
  static const String Language = 'user_language';
}