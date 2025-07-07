import 'dart:convert';
import 'package:eboss_tuonglong/Access/keyservices.dart';
import 'package:eboss_tuonglong/Access/sharedpreferencesservice.dart';
import 'package:eboss_tuonglong/common/dialogmessageerror.dart';
import 'package:eboss_tuonglong/common/loadingoverlay.dart';
import 'package:eboss_tuonglong/common/snackbarerror.dart';
import 'package:eboss_tuonglong/services/HostService.dart';
import 'package:eboss_tuonglong/widgets/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetWorkRequest {
   static final timeout = Duration(seconds: 15);
  NetWorkRequest() {}

  static Future<Map<String, dynamic>> PostDefault(
    String endpoint,
    Map<String, dynamic> data,
    BuildContext context,
  ) async {
    try {
      String url = HostService.Host_Mobile + endpoint;
      // Post API
      final response = await http
          .post(
            Uri.parse(url),
            headers: <String, String>{
              'eBOSSTUONGLONG': SharedPreferencesService.getString(
                KeyServices.Token,
              ),
              'eBOSS_API_LanguageID': 'VN',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data),
          )
          .timeout(timeout);
      return _handleResponseContext(response, context);
    } catch (e) {
      SnackbarError.showSnackbar_Error(context, message: "Lỗi kết nối máy chủ");
      throw Exception('Lỗi kết nối máy chủ');
    }
  }

  static Future<Map<String, dynamic>> Post(
    String endpoint,
    Map<String, dynamic> data,
    BuildContext context,
  ) async {
    String url = HostService.Host_Mobile + endpoint;
    // Post API
    final response = await http
        .post(
          Uri.parse(url),
          headers: {
            'eBOSSTUONGLONG': SharedPreferencesService.getString(
              KeyServices.Token,
            ),
            'eBOSS_API_LanguageID': 'VN',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data),
        )
        .timeout(timeout);
    return _handleResponseContext(response, context);
  }

  static Future<Map<String, dynamic>> PutDefault(
    String endpoint,
    Map<String, dynamic> data,
    BuildContext context,
  ) async {
    try {
      String url = HostService.Host_Mobile + endpoint;
      // Post API
      final response = await http
          .put(
            Uri.parse(url),
            headers: <String, String>{
              'eBOSSTUONGLONG': SharedPreferencesService.getString(
                KeyServices.Token,
              ),
              'eBOSS_API_LanguageID': 'VN',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data),
          )
          .timeout(timeout);
      return _handleResponseContext(response, context);
    } catch (e) {
      SnackbarError.showSnackbar_Error(context, message: "Lỗi kết nối máy chủ");
      throw Exception('Lỗi kết nối máy chủ');
    }
  }

  static Future<Map<String, dynamic>> Get(
    String endpoint,
    BuildContext context,
  ) async {
    String url = HostService.Host_Mobile + endpoint;
    final response = await http
        .get(
          Uri.parse(url),
          headers: {
            'eBOSSTUONGLONG': SharedPreferencesService.getString(
              KeyServices.Token,
            ),
            'eBOSS_API_LanguageID': 'VN',
            'Content-Type': 'application/json',
          },
        )
        .timeout(timeout);
    return _handleResponseContext(response, context);
  }

  static Future<Map<String, dynamic>> GetDefault(
    String endpoint,
    BuildContext context,
  ) async {
    try {
      String url = HostService.Host_Mobile + endpoint;
      // Post API
      final response = await http
          .get(
            Uri.parse(url),
            headers: <String, String>{
              'eBOSSTUONGLONG': SharedPreferencesService.getString(
                KeyServices.Token,
              ),
              'eBOSS_API_LanguageID': 'VN',
              'Content-Type': 'application/json',
            },
          )
          .timeout(timeout);
      return _handleResponseContext(response, context);
    } catch (e) {
      SnackbarError.showSnackbar_Error(context, message: "Lỗi kết nối máy chủ");
      throw Exception('Lỗi kết nối máy chủ');
    }
  }

  static Future<Map<String, dynamic>> _handleResponseContext(
    http.Response response,
    BuildContext context,
  ) async {
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Trả về dữ liệu đã được giải mã từ JSON
        return json.decode(response.body);
      } else {
        // Xử lý lỗi và thông báo cho phía gọi
        if (response.statusCode == 500) {
          await DialogMessage_Error.showMyDialog(
            context,
            json.decode(response.body),
          );
        } else if (response.statusCode == 401) {
          SnackbarError.showSnackbar_Error(
            context,
            message: json.decode(response.body),
          );
        } else {
          SnackbarError.showSnackbar_Error(context, message: response.body);
        }
        //throw Exception('${response.statusCode.toString()}');
        // Trả về một Map rỗng thay vì chuỗi để tránh lỗi kiểu dữ liệu
        return {"error": ""};
      }
    } catch (e) {
      SnackbarError.showSnackbar_Error(context, message: "Lỗi kết nối máy chủ");
      Error404(context);
      throw Exception('${response.statusCode.toString()}');
    }
  }

  static Future<void> Error404(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
