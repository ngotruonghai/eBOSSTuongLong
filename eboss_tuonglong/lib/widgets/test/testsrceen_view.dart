import 'package:eboss_tuonglong/Access/mobilelanguageprovider.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';
import 'package:flutter/material.dart';
import 'package:eboss_tuonglong/Access/functionApp.dart';

class TestsrceenView extends StatefulWidget {
  const TestsrceenView({super.key});

  @override
  State<TestsrceenView> createState() => _TestsrceenViewState();
}

class _TestsrceenViewState extends State<TestsrceenView> {
  // Với lớp tĩnh, chúng ta không cần các biến trạng thái
  // như _languageProvider, _languages, hay _isLoading ở đây nữa.

  @override
  void initState() {
    super.initState();
    // LƯU Ý QUAN TRỌNG:
    // Để có hiệu suất tốt nhất, bạn nên gọi `LoadAppMobileLanguage.initialize()`
    // một lần duy nhất trong hàm `main()` của ứng dụng, trước khi `runApp()` được gọi.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 2. Sử dụng widget tiện ích LanguageText để tải tiêu đề
        title: const LanguageText(
          nameId: 'list_title', // Giả sử có một NameID là 'list_title'
          defaultValue: 'Danh sách Ngôn ngữ',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 3. Hiển thị một vài trường đơn giản để chứng minh hàm chạy
            const Text(
              'Các chuỗi được tải từ lớp tĩnh:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 10),

            // VÍ DỤ 1: Tải chuỗi 'hello'
            _buildLanguageRow(
              label: 'ID "hello":',
              nameId: 'ghichu',
              defaultValue: 'Không tải được',
              style: const TextStyle(fontSize: 22, color: Colors.blue),
            ),
            const SizedBox(height: 20),

            // VÍ DỤ 2: Tải chuỗi 'save'
            _buildLanguageRow(
              label: 'ID "save":',
              nameId: 'save',
              defaultValue: 'Không tải được',
              style: const TextStyle(fontSize: 22, color: Colors.green),
            ),
            const SizedBox(height: 20),

            // VÍ DỤ 3: Tải một chuỗi không tồn tại để kiểm tra giá trị mặc định
            _buildLanguageRow(
              label: 'ID "non_existent_key":',
              nameId: '1',
              defaultValue: 'Đây là giá trị mặc định',
              style: const TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm tiện ích để giao diện gọn gàng hơn
  Widget _buildLanguageRow({
    required String label,
    required String nameId,
    required String defaultValue,
    TextStyle? style,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        LanguageText(
          nameId: nameId,
          defaultValue: defaultValue,
          style: style,
        ),
      ],
    );
  }
}
