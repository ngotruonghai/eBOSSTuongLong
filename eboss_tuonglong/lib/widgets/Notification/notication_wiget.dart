import 'package:eboss_tuonglong/model/Notification/notificationmodel.dart'
    as noticationModel;
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';

class NoticationApp extends StatefulWidget {
  const NoticationApp({super.key});

  @override
  State<NoticationApp> createState() => _NoticationAppState();
}

class _NoticationAppState extends State<NoticationApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<noticationModel.Data> lsThongbao = [];

  Future<int> API_LoadDanhSachThongBao(BuildContext context) async {
    final response = await NetWorkRequest.GetDefault(
      "/api/Notification/GetAllNotificationByUser",
      context,
    );
    final parsed = noticationModel.NotificationModel.fromJson(response);
    lsThongbao = parsed.data ?? [];
    return 1;
  }

  Future<void> _refreshData() async {
    await API_LoadDanhSachThongBao(context);
    setState(() {});
  }

  Future<bool> loadData(BuildContext context) async {
    try {
      await API_LoadDanhSachThongBao(context);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F615C),
        title: Text(
          "Thông báo",
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<bool>(
          future: loadData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Hiển thị trang tải
              return Center(
                child: CircularProgressIndicator(color: Color(0xFF1F615C)),
              );
            } else {
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children:
                        lsThongbao.map((item) {
                          return InkWell(
                            onTap: () {                            },
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Người cập nhật: "),
                                        Expanded(
                                          child: Text(
                                            item.nameVietnamese.toString(),
                                            style: const TextStyle(
                                              
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("Nội dung: "),
                                        Expanded(
                                          child: Text(
                                            item.noiDung.toString(),
                                            style: const TextStyle(
                                              
                                              // fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    
                                    const SizedBox(height: 4),
                                    
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
