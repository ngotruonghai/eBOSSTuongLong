import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:eboss_tuonglong/Access/keyservices.dart';
import 'package:eboss_tuonglong/Access/mobilelanguageprovider.dart';
import 'package:eboss_tuonglong/Access/sharedpreferencesservice.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';
import 'package:eboss_tuonglong/services/NotificationService.dart';
import 'package:eboss_tuonglong/widgets/GiaoHangMau/danhsachphieugiaohangmau_widgets.dart';
import 'package:eboss_tuonglong/widgets/Notification/notication_wiget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeViewScreen extends StatefulWidget {
  const HomeViewScreen({super.key});

  @override
  State<HomeViewScreen> createState() => _HomeViewScreenState();
}

class _HomeViewScreenState extends State<HomeViewScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // Bọc toàn bộ nội dung bằng SingleChildScrollView để có thể cuộn
      body: SingleChildScrollView(
        child: Column(
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
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      NotificationService.resetBadge();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // InkWell(
                                //   onTap: () => {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             DanhSachPhieuGiaoHangMauWidgets(
                                //           Type: 0,
                                //         ),
                                //       ),
                                //     ),
                                //   },
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       Icon(
                                //         Icons.warehouse_outlined,
                                //         color: const Color.fromARGB(
                                //             255, 36, 133, 73),
                                //         size: 50,
                                //       ),
                                //       SizedBox(height: 5),
                                //       LanguageText(
                                //         nameId: '20',
                                //         defaultValue: 'Phiếu giao hàng',
                                //         style: TextStyle(
                                //           fontSize: 12,
                                //           fontWeight: FontWeight.bold,
                                //           color: Colors.black,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                InkWell(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DanhSachPhieuGiaoHangMauWidgets(
                                          Type: 1,
                                        ),
                                      ),
                                    ),
                                  },
                                  child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.indeterminate_check_box,
                                        color: const Color.fromARGB(
                                            255, 36, 133, 73),
                                        size: 50,
                                      ),
                                       SizedBox(height: 5),
                                      LanguageText(
                                        nameId: '18',
                                        defaultValue: 'Phiếu đã giao',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 30),
                                InkWell(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DanhSachPhieuGiaoHangMauWidgets(
                                          Type: 2,
                                        ),
                                      ),
                                    ),
                                  },
                                  child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.layers_outlined,
                                        color: const Color.fromARGB(
                                            255, 36, 133, 73),
                                        size: 50,
                                      ),
                                       SizedBox(height: 5),
                                      LanguageText(
                                        nameId: '23',
                                        defaultValue: 'Phiếu chưa giao',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
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
            // Loại bỏ Expanded và Column con không cần thiết
            Image(
              image: AssetImage("assets/img_tuonglong.png"),
              width: double.infinity,
              height: 300,
            ),
            // Bạn có thể thêm các widget khác ở đây và chúng cũng sẽ cuộn
          ],
        ),
      ),
    );
  }

  /* START Function */
  // late String _tennguoidung =
  //     SharedPreferencesService.getString(KeyServices.UserName);
  /* END Function */
}