import 'package:eboss_tuonglong/Access/keyservices.dart';
import 'package:eboss_tuonglong/Access/sharedpreferencesservice.dart';
// import 'package:eboss_tuonglong/DatabaseHelper/mobilelanguageProvider.dart'; // Đã loại bỏ
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
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String _selectedLanguage = 'VI'; // Mặc định là Tiếng Việt
  bool _IsShowPassword = true;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  void _loadLanguage() async {
    await SharedPreferencesService.setString(KeyServices.Language,_selectedLanguage);
    
  }

  // Sửa lại hàm để nhận giá trị non-nullable
  void _changeLanguage(String newLanguage) {
    setState(() {
     _selectedLanguage = newLanguage;
        SharedPreferencesService.setString(KeyServices.Language, newLanguage);
    });
  }

  String _getTranslatedString(String viText, String enText) {
    return _selectedLanguage == 'VI' ? viText : enText;
  }

  @override
  Widget build(BuildContext context) {
    return LoginProvider(
      child: Scaffold(
        body: BlocBuilder<LoginBloc, Loginstate>(
          builder: (context, state) {
            if (state == Loginstate.LoginProgress ||
                state == Loginstate.Success) {
              return const Home_Screen();
            } else if (state == Loginstate.CreateUser) {
              return const DangKyUserSreecn();
            } else {
              return _LoginWidget(context);
            }
          },
        ),
      ),
    );
  }
Widget _LoginWidget(BuildContext context) {
  return Container(
    color: const Color(0xFFD1E3DC),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Phần nội dung chính có thể cuộn
            Expanded(
              // ✨ THAY ĐỔI 1: BỎ WIDGET `Center` BỌC BÊN NGOÀI
              child: SingleChildScrollView(
                child: Column(
                  // ✨ THAY ĐỔI 2: ĐỔI THÀNH .start ĐỂ CĂN LÊN TRÊN
                  mainAxisAlignment: MainAxisAlignment.start, 
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 150,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F615C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Image(
                          image: AssetImage("assets/logoTuongLong.png"),
                          width: 300,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _getTranslatedString('Đăng nhập', 'Login'),
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _username,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: _getTranslatedString('Tài khoản', 'Username'),
                        labelStyle: const TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.blueGrey),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _password,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: _getTranslatedString('Mật khẩu', 'Password'),
                        labelStyle: const TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.lock, color: Colors.blueGrey),
                        suffixIcon: IconButton(
                        icon: Icon(
                          _IsShowPassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.blueGrey,
                        ),
                        onPressed: () {
                          setState(() {
                            _IsShowPassword = !_IsShowPassword;
                          });
                        },
                      ),
                      ),
                      obscureText: _IsShowPassword,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildLanguageSelector(context),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          _Loginhandle(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF225F59),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          _getTranslatedString('Đăng nhập', 'Login'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Phần footer vẫn được giữ ở dưới cùng
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              child: Text(
                _getTranslatedString(
                    'Được phát triển bản quyền bởi eBOSS',
                    'Developed by eBOSS'),
                style: const TextStyle(
                  color: Colors.grey,
                  fontFamily: "Roboto",
                  fontSize: 13,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Center(
                child: Text(
                  "eBOSS V1.1.2 ",
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
  );
}void _Loginhandle(BuildContext context) {
    context.read<LoginBloc>().add( LoginClickEvent(_username.text, _password.text, context));

  }

// **WIDGET ĐÃ SỬA: GIỜ LÀ NÚT BẤM ĐỂ MỞ POPUP**
  Widget _buildLanguageSelector(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showLanguagePicker(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedLanguage == 'VI' ? 'Tiếng Việt 🇻🇳' : 'English 🇬🇧',
              style: const TextStyle(color: Colors.black87),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  // **HÀM MỚI ĐỂ HIỂN THỊ POPUP (MODAL BOTTOM SHEET)**
  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _getTranslatedString('Chọn ngôn ngữ', 'Select Language'),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildLanguageOption(context, 'Tiếng Việt 🇻🇳', 'VI'),
              const Divider(),
              _buildLanguageOption(context, 'English 🇬🇧', 'EN'),
            ],
          ),
        );
      },
    );
  }

  // Widget cho mỗi lựa chọn trong popup
  Widget _buildLanguageOption(
      BuildContext context, String title, String languageCode) {
    final bool isSelected = _selectedLanguage == languageCode;
    return ListTile(
      title: Text(title),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor)
          : null,
      onTap: () {
        _changeLanguage(languageCode);
        Navigator.pop(context); // Đóng popup sau khi chọn
      },
    );
  }
}
