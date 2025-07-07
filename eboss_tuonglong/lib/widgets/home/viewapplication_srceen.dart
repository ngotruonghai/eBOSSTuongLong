import 'package:eboss_tuonglong/Access/keyservices.dart';
import 'package:eboss_tuonglong/Access/sharedpreferencesservice.dart';
import 'package:eboss_tuonglong/widgets/GiaoHangMau/danhsachphieugiaohangmau_widgets.dart';
import 'package:eboss_tuonglong/widgets/Notification/notication_wiget.dart';
import 'package:eboss_tuonglong/widgets/thongke/danhsachsanphammau_sreen.dart';
import 'package:eboss_tuonglong/widgets/thongke/thongkegiaohangmaui_srceen.dart';
import 'package:flutter/material.dart';

class ViewapplicationSrceen extends StatefulWidget {
  const ViewapplicationSrceen({super.key});

  @override
  State<ViewapplicationSrceen> createState() => _ViewapplicationSrceenState();
}

class _ViewapplicationSrceenState extends State<ViewapplicationSrceen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
            padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Danh sách báo cáo",style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold),),
                Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: AssetImage("assets/iconquanlykho.png"),
                        width: 90,
                        height: 90,
                      ),
                      Text(
                        "Giao hàng mẫu",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.09), // Khoảng cách giữa các ô
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
                        width: 90,
                        height: 90,
                      ),
                      Text(
                        "Tiến độ sản xuất",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                // // Ô 3
                // InkWell(
                //   onTap: () {
                //     // TODO: Chuyển trang khác
                //   },
                //   child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Image(
                //         image: AssetImage("assets/iconquanlykho.png"),
                //         width: 90,
                //         height: 90,
                //       ),
                //       Text(
                //         "Chức năng 3",
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 15,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          
              ],
            )),
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
