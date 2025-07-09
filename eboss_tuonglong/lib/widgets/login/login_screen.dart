import 'package:eboss_tuonglong/bloc/Login/LoginBloc.dart';
import 'package:eboss_tuonglong/bloc/Login/LoginEvent.dart';
import 'package:eboss_tuonglong/bloc/Login/loginprovider.dart';
import 'package:eboss_tuonglong/bloc/Login/loginstate.dart';
import 'package:eboss_tuonglong/widgets/home/home_screen.dart';
import 'package:eboss_tuonglong/widgets/login/dangkyuser_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  // late LoginBloc _loginBloc; // Khởi tạo biến LoginBloc

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoginProvider(
      child: Scaffold(
        body: BlocBuilder<LoginBloc, Loginstate>(
          builder: (context, state) {
            if (state == Loginstate.LoginInnitial) {
              return _LoginWidget(context);
            } else if (state == Loginstate.LoginProgress) {
              return Home_Screen();
            } else if (state == Loginstate.Success) {
              return Home_Screen();
            } else if (state == Loginstate.CreateUser) {
              return DangKyUserSreecn();
            } else {
              return _LoginWidget(context);
            }
          },
        ),
      ),
    );
  }

  void _Loginhandle(BuildContext context) {
    context.read<LoginBloc>().add(
      LoginClickEvent(_username.text, _password.text, context),
    );
  }

  Widget _LoginWidget(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          color: Color(0xFFD1E3DC), // Màu nền
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: double.infinity, // Độ rộng của hình
                    height: 150, // Độ cao của hình
                    decoration: BoxDecoration(
                      color: Color(0xFF1F615C), // Màu nền xanh đậm
                      borderRadius: BorderRadius.circular(20), // Bo tròn góc
                      border: Border.all(
                        color: Color(0xFF1F615C),
                      ), // Viền xanh dương
                    ),
                    child: Image(
                      image: AssetImage("assets/logoTuongLong.png"),
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Đăng nhập",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold, // Đậm
                    color: Colors.black, // Màu chữ đen
                  ),
                ),

                const SizedBox(height: 10),
                TextField(
                  controller: _username,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Tài khoản',
                    //hintText: "Tài khoản",
                    labelStyle: const TextStyle(color: Colors.blueGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _password,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    //hintText: "Mật khẩu",
                    labelText: "Mật khẩu",
                    labelStyle: const TextStyle(color: Colors.blueGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.lock, color: Colors.blueGrey),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      _Loginhandle(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0XFF225F59,
                      ), // Blue background
                      foregroundColor: Colors.white, // White text
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // Optional: Rounded corners
                      ),
                    ),
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Center(
                    child: Text(
                      "Được phát triển bản quyền bởi eBOSS",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Roboto",
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Center(
                    child: Text(
                      "eBOSS V1.0.8",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Roboto",
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
