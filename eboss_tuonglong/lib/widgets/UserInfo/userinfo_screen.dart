import 'package:eboss_tuonglong/Access/keyservices.dart';
import 'package:eboss_tuonglong/widgets/UserInfo/component/userinfo_list_tile_component.dart';
import 'package:eboss_tuonglong/widgets/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:eboss_tuonglong/Access/sharedpreferencesservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreen();
}

class _UserInfoScreen extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      child: Image.asset(
                        "assets/userinfo_image.png",
                        width: screenWidth,
                        height: screenWidth * 0.37,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.11),
                    Center(
                      child: Text(
                        SharedPreferencesService.getString(
                          KeyServices.UserName,
                        ),
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          backgroundColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: screenWidth * 0.14),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            width: screenWidth * 0.25,
                            height: screenWidth * 0.25,
                            color: Colors.white,
                          ),
                        ),
                        ClipOval(
                          child: Image.asset(
                            "assets/profile.png",
                            width: screenWidth * 0.23,
                            height: screenWidth * 0.23,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            Center(
              child: Text(
                "",
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: screenWidth * 0.033),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.04),
                child: Text(
                  "Thông tin",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    backgroundColor: Colors.white,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            SizedBox(height: screenWidth * 0.04),

            UserinfoListTileComponent(
              screenWidth: screenWidth,
              icon: "assets/profile.png",
              text: "Cá Nhân",
              subText:
                  "Lý lịch, người thân, danh sách đăng ký người phụ thuộc, visa, hộ chiếu, GPLD, bằng cấp, chứng chỉ, kinh nghiệm làm việc",
              data: ["123"],
              containSubtext: true,
            ),

            SizedBox(height: screenWidth * 0.04),

            UserinfoListTileComponent(
              screenWidth: screenWidth,
              icon: "assets/profile.png",
              text: "Quá trình làm việc tại Công ty",
              subText:
                  "Hợp đồng, quá trình làm việc, chức danh kiểm nhiệm, khen thưởng, kỷ luật",
              data: ["123"],
              containSubtext: true,
            ),

            SizedBox(height: screenWidth * 0.04),

            UserinfoListTileComponent(
              screenWidth: screenWidth,
              icon: "assets/profile.png",
              text: "Thu nhập",
              subText:
                  "Phiếu lương, phiếu thưởng, quyết toán thuế TNCN, quá trình lương",
              data: ["123"],
              containSubtext: true,
            ),

            SizedBox(height: screenWidth * 0.04),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.04),
                child: Text(
                  "Cài đặt",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    backgroundColor: Colors.white,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            SizedBox(height: screenWidth * 0.04),

            UserinfoListTileComponent(
              screenWidth: screenWidth,
              icon: "assets/profile.png",
              text: "Ngôn ngữ",
              subText: "Tiếng việt",
              data: ["123"],
              containSubtext: true,
            ),

            SizedBox(height: screenWidth * 0.04),

            UserinfoListTileComponent(
              screenWidth: screenWidth,
              icon: "assets/profile.png",
              text: "Bảo mật ứng dụng",
              subText: "Khoá ứng dụng bằng sinh trắc học",
              data: ["123"],
              containSubtext: true,
            ),

            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: 50, top: 20),
                child: Container(
                  alignment: Alignment.centerLeft, // Đặt nội dung về bên trái
                  child: Text("Đăng xuất"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
