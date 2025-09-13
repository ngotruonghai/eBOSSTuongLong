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
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        // Header bo góc
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: Offset(0, 1))],
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
                  padding: const EdgeInsets.only(top: 50, bottom: 20, left: 16, right: 16),
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
                style: TextStyle(fontSize: 15, color: Color(0xFF424242), fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ThongKeGiaoHangMauSrceen()));
                    },
                    child: _buildIcon(
                      assetImage: 'assets/iconquanlykho.png',
                      nameId: 'theodoitiengiaohangmau',
                      defaultValue: 'Giao hàng mẫu',
                    ),
                  ),
                  // Khoảng cách giữa các ô
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DanhSachSanPhamMauSreen()));
                    },
                    child: _buildIcon(
                      assetImage: 'assets/iconthongke.png',
                      nameId: 'tiendosanxuat',
                      defaultValue: 'Tiến độ sản xuất',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ThongketheodoitiendomauSreen()));
                    },
                    child: _buildIcon(
                      assetImage: 'assets/icon_theodoitiendomau.png',
                      nameId: 'theodoitiendomau',
                      defaultValue: 'Tiến độ sản xuất',
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ThongKeTheoDoiXuLyMauSrceen()));
                    },
                    child: _buildIcon(
                      assetImage: 'assets/icontheodoitiendoxulymau.png',
                      nameId: 'tiendoxulymau',
                      defaultValue: 'Tiến độ xử lý mẫu',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildIcon({required String assetImage, required String nameId, required String defaultValue}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8),
        menuImage(assetImage, height: screenHeight * 0.08),
        SizedBox(height: 4),
        SizedBox(
          width: screenWidth * 0.3,
          child: LanguageText(
            nameId: nameId,
            defaultValue: defaultValue,
            style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
          ),
        ),
      ],
    );
  }

  Widget menuImage(String imagePath, {double height = 40}) {
    return Image.asset(imagePath, height: height, fit: BoxFit.contain);
  }
}
