import 'package:eboss_tuonglong/DatabaseHelper/mobilelanguageProvider.dart';
import 'package:eboss_tuonglong/model/SongNgu/mobileapplanguge.dart'
    as MobileLanguageModel;
import 'package:eboss_tuonglong/Access/sharedpreferencesservice.dart';
import 'package:eboss_tuonglong/Access/keyservices.dart';
import 'package:eboss_tuonglong/services/HostService.dart';

class LoadAppMobileLanguage {
  static final MobileLanguageProvider _provider = MobileLanguageProvider.instance;
  static List<MobileLanguageModel.Data> _languages = []; // Cache để lưu dữ liệu
  static bool _isInitialized = false; // Cờ để kiểm tra đã khởi tạo chưa

  // Constructor private để ngăn việc tạo đối tượng từ bên ngoài
  LoadAppMobileLanguage._();
  static Future<void> initialize() async {

    if (_isInitialized) return; // Nếu đã khởi tạo rồi thì không chạy lại
    //await _provider.checkDatabaseExists();
    //await _provider.UpDateLanguage(); // Đảm bảo database đã sẵn sàng
    _languages = await _provider.getAll();
    _isInitialized = true;
  }

  static Future<String> Get(
    String NameId, {
    required String NameDefault,
  }) async {
    String languagename = "VI";
    if (SharedPreferencesService.containsKey(KeyServices.Language) == true) {
      languagename =
          SharedPreferencesService.getString(KeyServices.Language) ?? 'VI';
    }
    try {
      // Dùng `firstWhere` để tìm phần tử trong cache.
      final language = _languages.firstWhere((lang) => lang.nameID == NameId);
      String? result;

      if(HostService.OnOffSongNgu == false){
        languagename = "None";
      }

      // Chọn chuỗi ngôn ngữ phù hợp dựa trên lựa chọn của người dùng
      switch (languagename.toUpperCase()) {
        case 'VI':
        case 'VN':
          result = language.nameVietnamese;
          break;
        case 'EN':
          result = language.nameEnglish;
          break;
        case 'CN':
        case 'CH':
          result = language.nameChinese;
          break;
        default:
          result = language.nameVietnamese; // Mặc định lấy tiếng Việt
      }

      if (result != null && result.isNotEmpty) {
        return result;
      }

      return NameDefault;
    } catch (e) {
      print("lỗi xử lý ngôn ngữ AppMobile tổng số lượng ngôn ngữ: ${_languages.length}");
      return NameDefault;
    }
  }
  static Future<void> clearData() async {
    _languages.clear(); // Xóa cache
    _isInitialized = false; // Đặt lại cờ khởi tạo
    await _provider.deleteDatabaseFile(); // Xóa dữ liệu trong database
  }
  static Future<void> updateLanguage() async {
    await _provider.UpDateLanguage(); // Cập nhật dữ liệu từ server
    _languages = await _provider.getAll(); // Cập nhật lại cache
    _isInitialized = true; // Đặt lại cờ khởi tạo
  }
  static Future<void> LoadOldData() async {
     _languages = await _provider.getAll(); // Cập nhật lại cache
    _isInitialized = true; // Đặt lại cờ khởi tạo
  }

 static String GetStringLanguage(
    String NameId, {
    required String NameDefault,
  })  {
    String languagename = "VI";
    if (SharedPreferencesService.containsKey(KeyServices.Language) == true) {
      languagename =
          SharedPreferencesService.getString(KeyServices.Language) ?? 'VI';
    }
    try {
      // Dùng `firstWhere` để tìm phần tử trong cache.
      final language = _languages.firstWhere((lang) => lang.nameID == NameId);
      String? result;
      // Chọn chuỗi ngôn ngữ phù hợp dựa trên lựa chọn của người dùng
      switch (languagename.toUpperCase()) {
        case 'VI':
        case 'VN':
          result = language.nameVietnamese;
          break;
        case 'EN':
          result = language.nameEnglish;
          break;
        case 'CN':
        case 'CH':
          result = language.nameChinese;
          break;
        default:
          result = language.nameVietnamese; // Mặc định lấy tiếng Việt
      }

      if (result != null && result.isNotEmpty) {
        return result;
      }

      return NameDefault;
    } catch (e) {
      print("lỗi xử lý ngôn ngữ AppMobile tổng số lượng ngôn ngữ: ${_languages.length}");
      return NameDefault;
    }
  }

}
