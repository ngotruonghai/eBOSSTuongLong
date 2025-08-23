import 'package:eboss_tuonglong/Access/keyservices.dart';
import 'package:eboss_tuonglong/Access/sharedpreferencesservice.dart';
import 'package:eboss_tuonglong/widgets/GiaoHangMau/danhsachphieugiaohangmau_widgets.dart';
import 'package:eboss_tuonglong/widgets/Notification/notication_wiget.dart';
import 'package:eboss_tuonglong/widgets/thongke/danhsachsanphammau_sreen.dart';
import 'package:eboss_tuonglong/widgets/thongke/thongkegiaohangmaui_srceen.dart';
import 'package:eboss_tuonglong/widgets/thongke/thongketheodoitiendomau_sreen.dart';
import 'package:eboss_tuonglong/widgets/thongke/thongketheodoitiendoxulymau_srceen.dart';
import 'package:flutter/material.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';

class ViewapplicationSrceen extends StatefulWidget {
  const ViewapplicationSrceen({super.key});

  @override
  State<ViewapplicationSrceen> createState() => _ViewapplicationSrceenState();
}

class _ViewapplicationSrceenState extends State<ViewapplicationSrceen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          // Header bo góc
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 1),
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
                    height: 100,
                    padding: const EdgeInsets.only(
                      top: 50,
                      bottom: 20,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      children: [
                        // ...các widget khác nếu có...
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Hàng ngang các ô chức năng nằm ngay dưới header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LanguageText(
                  nameId: '6',
                  defaultValue: 'Danh sách báo cáo',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThongKeGiaoHangMauSrceen(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage("assets/iconquanlykho.png"),
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.1,
                          ),
                          Container(
                            child: LanguageText(
                              nameId: 'theodoitiengiaohangmau',
                              defaultValue: 'Giao hàng mẫu',
                              style: TextStyle(fontSize: 12, color: Colors.grey)
                            ),
                            width: screenWidth * 0.3,
                          ),
                        ],
                      ),
                    ),
                    // Khoảng cách giữa các ô
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DanhSachSanPhamMauSreen(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage("assets/iconthongke.png"),
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.1,
                          ),
                          Container(
                            child: LanguageText(
                              nameId: 'tiendosanxuat',
                              defaultValue: 'Tiến độ sản xuất',
                              style: TextStyle(fontSize: 12, color: Colors.grey)
                            ),
                            width: screenWidth * 0.3,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThongketheodoitiendomauSreen(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage("assets/icon_theodoitiendomau.png"),
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                          ),
                          Container(
                            child: LanguageText(
                              nameId: 'theodoitiendomau',
                              defaultValue: 'Tiến độ sản xuất',
                             style: TextStyle(fontSize: 12, color: Colors.grey)
                            ),
                            width: screenWidth * 0.3,
                          ),
                        ],
                      ),
                    ),                    
                  ],
                ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThongKeTheoDoiXuLyMauSrceen(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage("assets/icontheodoitiendoxulymau.png"),
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                          ),
                          Container(
                            child: LanguageText(
                              nameId: 'tiendoxulymau',
                              defaultValue: 'Tiến độ xử lý mẫu',
                             style: TextStyle(fontSize: 12, color: Colors.grey)
                            ),
                            width: screenWidth * 0.3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Nội dung còn lại bên dưới
          Expanded(
            child: Container(
              // Nội dung khác ở đây
            ),
          ),
        ],
      ),
    );
  }
}
