import 'package:eboss_tuonglong/Access/keyservices.dart';
import 'package:eboss_tuonglong/Access/mobilelanguageprovider.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';
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
                          fontSize: 15,
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
                  fontSize: 13,
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
                child: LanguageText(
                  nameId: "30",
                  defaultValue: "Thông tin",
                  style: TextStyle(
                    fontSize: 15,
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
              text: LoadAppMobileLanguage.GetStringLanguage("2", NameDefault: "VN"),
              subText: LoadAppMobileLanguage.GetStringLanguage("LyLich", NameDefault: "VN"),
              data: ["123"],
              containSubtext: true,
            ),

            SizedBox(height: screenWidth * 0.04),

            UserinfoListTileComponent(
              screenWidth: screenWidth,
              icon: "assets/profile.png",
              text: LoadAppMobileLanguage.GetStringLanguage("Wokring", NameDefault: "VN"),
              subText: LoadAppMobileLanguage.GetStringLanguage("Contract", NameDefault: "VN"),
              data: ["123"],
              containSubtext: true,
            ),

            SizedBox(height: screenWidth * 0.04),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.04),
                child: LanguageText(
                  nameId: "3",
                  defaultValue: "Cài đặt",
                  style: TextStyle(
                    fontSize: 13,
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
              text: LoadAppMobileLanguage.GetStringLanguage("15", NameDefault: "VN"),
              subText: LoadAppMobileLanguage.GetStringLanguage("Vietnamese", NameDefault: "VN"),
              data: ["123"],
              containSubtext: true,
            ),

            SizedBox(height: screenWidth * 0.04),
            
            Padding(padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(Icons.logout),
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
                    padding: EdgeInsets.only(left: 10, top: 0),
                    child: Container(
                      alignment:
                          Alignment.centerLeft, // Đặt nội dung về bên trái
                      child: LanguageText(
                        nameId: "dangxuat",
                        defaultValue: "Đăng xuất",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),)
          ],
        ),
      ),
    );
  }
}
