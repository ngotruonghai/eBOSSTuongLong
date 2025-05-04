import 'package:eboss_tuonglong/Access/keyservices.dart';
import 'package:eboss_tuonglong/Access/sharedpreferencesservice.dart';
import 'package:eboss_tuonglong/widgets/GiaoHangMau/danhsachphieugiaohangmau_widgets.dart';
import 'package:eboss_tuonglong/widgets/Notification/notication_wiget.dart';
import 'package:flutter/material.dart';

class HomeViewScreen extends StatefulWidget {
  const HomeViewScreen({super.key});

  @override
  State<HomeViewScreen> createState() => _HomeViewScreenState();
}

//SharedPreferencesService.getString(KeyServices.UserName)
class _HomeViewScreenState extends State<HomeViewScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // Màu bóng
                        blurRadius: 15, // Độ mờ bóng
                        offset: Offset(0, 1), // Đổ bóng xuống dưới
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Container(
                      color: Color(0xFF225F59),
                      height: 200,
                      padding: const EdgeInsets.only(
                        top: 50, // Padding cho status bar
                        bottom: 20,
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        children: [
                          // Hàng đầu tiên: Avatar và thông tin
                          Row(
                            children: [
                              // Avatar
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.person, color: Colors.red),
                              ),
                              const SizedBox(width: 10),
                              // Số điện thoại và trạng thái
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    SharedPreferencesService.getString(
                                      KeyServices.UserName,
                                    ),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              // Nút gọi và 24/7
                              //Icon(Icons.phone, color: Colors.white),
                              SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                NoticationApp(),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                left: 0,
                right: 0,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 0),
                      Container(
                        width: screenWidth * 0.95,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color.fromARGB(255, 228, 228, 228),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 10,
                            right: 10,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap:
                                      () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    DanhSachPhieuGiaoHangMauWidgets(
                                                      Type: 0,
                                                    ),
                                          ),
                                        ),
                                      },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.warehouse_outlined,
                                        color: const Color.fromARGB(
                                          255,
                                          36,
                                          133,
                                          73,
                                        ), // Đổi màu
                                        size: 50, // Đổi kích thước
                                      ),
                                      Center(
                                        child: Text(
                                          "Phiếu giao hàng",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold, // Đậm
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  onTap:
                                      () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    DanhSachPhieuGiaoHangMauWidgets(
                                                      Type: 1,
                                                    ),
                                          ),
                                        ),
                                      },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.indeterminate_check_box,
                                        color: const Color.fromARGB(
                                          255,
                                          36,
                                          133,
                                          73,
                                        ), // Đổi màu
                                        size: 50, // Đổi kích thước
                                      ),
                                      Center(
                                        child: Text(
                                          "Phiếu đến hạn",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold, // Đậm
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  onTap:
                                      () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    DanhSachPhieuGiaoHangMauWidgets(
                                                      Type: 2,
                                                    ),
                                          ),
                                        ),
                                      },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.layers_outlined,
                                        color: const Color.fromARGB(
                                          255,
                                          36,
                                          133,
                                          73,
                                        ), // Đổi màu
                                        size: 50, // Đổi kích thước
                                      ),
                                      Center(
                                        child: Text(
                                          "Phiếu quá hạn",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold, // Đậm
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 100),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(
                    image: AssetImage("assets/img_tuonglong.png"),
                    width: double.infinity,
                    height: 300,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* START Function */
  // late String _tennguoidung =
  //     SharedPreferencesService.getString(KeyServices.UserName);
  /* END Function */
}
