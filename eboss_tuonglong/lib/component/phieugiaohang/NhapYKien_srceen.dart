import 'package:eboss_tuonglong/Access/mobilelanguageprovider.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';

class NhapykienSrceen extends StatefulWidget {
  final String ItemAID;
  final String ItemID;
  final String Type;

  const NhapykienSrceen({
    super.key,
    required this.ItemAID,
    required this.ItemID,
    required this.Type,
  });
  
  @override
  State<NhapykienSrceen> createState() => _NhapykienSrceenState();
}

class _NhapykienSrceenState extends State<NhapykienSrceen> {
  final TextEditingController _controllerCommet = TextEditingController();

  Future<void> _onConfirm() async {
    String content = _controllerCommet.text.trim();
    if (content.isNotEmpty) {

Map<String, dynamic> request = {
      "type": widget.Type,
      "comments": content,
      "aid": widget.ItemAID,
    };

    final response = await NetWorkRequest.PutDefault(
      "/api/PhieuGiaoHang/NhapYKienForm",
      request,
      context,
    );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập ý kiến trước khi gửi.')),
      );
    }
  }

  void _onCancel() {
    Navigator.of(context).pop(); // Đóng dialog
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LanguageText(nameId: "nhapykien", defaultValue: "Nhập ý kiến",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 12),
            TextField(
              controller: _controllerCommet,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: LoadAppMobileLanguage.GetStringLanguage("nhapykien", NameDefault: "Nhập ý kiến"),
                border: OutlineInputBorder(),
                labelStyle: const TextStyle(color: Colors.blueGrey),
                filled: true,
                fillColor: Colors.white,
                 focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueGrey, // Màu xanh dương
                  width: 2.0, // Dày hơn để nổi bật
                ),
              ),
              ),
              
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [                
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _onConfirm,
                  child: LanguageText(nameId: "xacnhan", defaultValue: "Xác nhận"),
                   style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF225F59),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                ),
                TextButton(
                  onPressed: _onCancel,
                  child: LanguageText(nameId: "huy", defaultValue: "Hủy",style: TextStyle(
                    color: Color.fromARGB(255, 1, 11, 10)
                  )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}