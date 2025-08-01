
import 'package:eboss_tuonglong/Access/mobilelanguageprovider.dart';
import 'package:flutter/material.dart';

/// Một Widget tiện ích để giảm việc lặp lại code FutureBuilder.
class LanguageText extends StatelessWidget {
  final String nameId;
  final String defaultValue;
  final TextStyle? style;

  const LanguageText({
    super.key,
    required this.nameId,
    required this.defaultValue,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      // Bây giờ, Dart sẽ hiểu đúng là đang gọi hàm 'get' từ lớp của bạn
      future: LoadAppMobileLanguage.Get(nameId, NameDefault: defaultValue),
      builder: (context, snapshot) {
        // Trong khi đang chờ dữ liệu, hiển thị giá trị mặc định
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('...', style: style?.copyWith(color: Colors.grey));
        }
        // Nếu có lỗi
        if (snapshot.hasError) {
          return Text('Lỗi tải', style: style?.copyWith(color: Colors.red));
        }
        // Nếu thành công, hiển thị dữ liệu nhận được
        return Text(
          textAlign: TextAlign.center,
          snapshot.data.toString().trim() ?? defaultValue,
          style: style,
           softWrap: true,
        );
      },
    );
  }
}

class LanguageText2 extends StatelessWidget {
  final String nameId;
  final String defaultValue;
  final String textstring;
  final TextStyle? style;

  const LanguageText2({
    super.key,
    required this.nameId,
    required this.defaultValue,
    required this.textstring,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      // Bây giờ, Dart sẽ hiểu đúng là đang gọi hàm 'get' từ lớp của bạn
      future: LoadAppMobileLanguage.Get(nameId, NameDefault: defaultValue),
      builder: (context, snapshot) {
        // Trong khi đang chờ dữ liệu, hiển thị giá trị mặc định
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('...', style: style?.copyWith(color: Colors.grey));
        }
        // Nếu có lỗi
        if (snapshot.hasError) {
          return Text('Lỗi tải', style: style?.copyWith(color: Colors.red));
        }
        // Nếu thành công, hiển thị dữ liệu nhận được
        return Text(
          (snapshot.data ?? defaultValue) + textstring,
          style: style,
        );
      },
    );
  }
}