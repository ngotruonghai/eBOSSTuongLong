import 'package:eboss_tuonglong/common/loadingoverlay.dart';
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:eboss_tuonglong/widgets/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DangKyUserSreecn extends StatefulWidget {
  const DangKyUserSreecn({super.key});

  @override
  State<DangKyUserSreecn> createState() => _DangKyUserSreecnState();
}

class _DangKyUserSreecnState extends State<DangKyUserSreecn> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<int> API_DangKyUser(BuildContext context) async {
    LoadingOverlay.show(context);
    Map<String, dynamic> request = {
      "password": passwordController.text,
      "passwordCheck": confirmPasswordController.text,
    };

    final response = await NetWorkRequest.PostDefault(
      "/api/User/CreatePassWord",
      request,
      context,
    );
    LoadingOverlay.hide(context);

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );

    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng ký mật khẩu"),
        backgroundColor: const Color(0xFF1F615C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPasswordField("Mật khẩu", passwordController),
            const SizedBox(height: 16),
            _buildPasswordField("Nhập lại mật khẩu", confirmPasswordController),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1F615C), // màu nền
                foregroundColor: Colors.white, // màu chữ
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                await API_DangKyUser(context);
              },
              child: const Text("Đăng ký"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        //hintText: "Mật khẩu",
        labelText: label,
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
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

class DangKyMatyKhauProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<void> LoadData(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await Future.wait([
      // loadChiTietGiaoHangMau(context, sampleAID),
      // loadChiTietNhapKho(context, sampleAID),
    ]);
    isLoading = false;
    notifyListeners();
  }
}
