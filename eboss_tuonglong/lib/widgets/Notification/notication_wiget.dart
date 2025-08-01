import 'package:eboss_tuonglong/common/LanguageText.dart';
import 'package:eboss_tuonglong/model/Notification/notificationmodel.dart'
    as notificationModel;
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';

// import 'package:intl/intl.dart'; // Không cần import này nếu không dùng DateFormat

class NoticationApp extends StatefulWidget {
  const NoticationApp({super.key});

  @override
  State<NoticationApp> createState() => _NoticationAppState();
}

class _NoticationAppState extends State<NoticationApp> {
  List<notificationModel.Data> _lsThongbao = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final response = await NetWorkRequest.GetDefault(
        "/api/Notification/GetAllNotificationByUser",
        context,
      );
      final parsed = notificationModel.NotificationModel.fromJson(response);
      setState(() {
        _lsThongbao = parsed.data ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Không thể tải thông báo. Vui lòng thử lại.";
        _isLoading = false;
        _lsThongbao = [];
      });
      print("Lỗi khi tải thông báo: $e");
    }
  }

  Future<void> _refreshData() async {
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F615C),
        title: const LanguageText(
          nameId: "ThongBao",
          defaultValue: "Thông báo",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child:
            _isLoading
                ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFF1F615C)),
                )
                : _errorMessage != null
                ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                )
                : _lsThongbao.isEmpty
                ? const Center(
                  child: LanguageText(
                    nameId: "NoThongBao",
                    defaultValue: "Bạn chưa có thông báo nào.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
                : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _lsThongbao.length,
                  itemBuilder: (context, index) {
                    final item = _lsThongbao[index];
                    return NotificationCard(notification: item);
                  },
                ),
      ),
    );
  }
}

// Widget riêng cho từng Card thông báo
class NotificationCard extends StatelessWidget {
  final notificationModel.Data notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          // TODO: Xử lý khi nhấn vào thông báo (ví dụ: mở chi tiết)
          print('Thông báo "${notification.tieuDe}" được nhấn!');
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon thông báo
              const Icon(
                Icons.notifications,
                color: Color(0xFF1F615C),
                size: 20,
              ),
              const SizedBox(width: 12),

              Expanded(
                // Expanded để nội dung chiếm hết không gian còn lại
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tiêu đề: Luôn tự động xuống dòng nếu có '\n' hoặc quá dài
                    Text(
                      notification.tieuDe?.toString() ?? "Không có tiêu đề",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
 const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Căn chỉnh theo chiều dọc
                      children: [
                        const LanguageText(
                          nameId: "Company",
                          defaultValue: "Công ty: ",
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                        Expanded(
                          // Expanded để Text tự động xuống dòng
                          child: Text(
                            notification.TenCongTy?.toString() ?? "",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Nhân viên kinh doanh
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Căn chỉnh theo chiều dọc
                      children: [
                        const LanguageText(
                          nameId: "SalesMan",
                          defaultValue: "Nhân viên kinh doanh: ",
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                        Expanded(
                          // Expanded để Text tự động xuống dòng
                          child: Text(
                            notification.NhanVienKinhDoanh?.toString() ?? "",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),                   
                    const SizedBox(height: 6),
                    // Nội dung
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Căn chỉnh theo chiều dọc
                      children: [
                        const LanguageText(
                          nameId: "NoiDung",
                          defaultValue: "Nội dung: ",
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                        Expanded(
                          // Expanded để Text tự động xuống dòng
                          child: Text(
                           (notification.noiDung?.toString() ?? ""),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6), // Khoảng cách cuối cùng
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
