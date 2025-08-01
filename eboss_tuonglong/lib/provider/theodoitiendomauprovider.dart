import 'package:eboss_tuonglong/model/TienDoSanXuat/theodoitiendomaumodel.dart';
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class TheoDoiTienDoMauProvider with ChangeNotifier {
  List<Data> _items = [];
  bool isLoading = true;

  List<Data> get items => _items;
  Future<void> LoadDanhSachTheoDoiTienDo(
    BuildContext context,
    String tuNgay,
    String denNgay,
    String refOrderID,
    String tenKhachHang,
    String nhanVienKinhDoanh,
  ) async {
    Map<String, dynamic> request = {
      "tuNgay": tuNgay,
      "denNgay": denNgay,
      "refOrderID": refOrderID,
      "tenKhachHang": tenKhachHang,
      "nhanVienKinhDoanh": nhanVienKinhDoanh,
    };

    final response = await NetWorkRequest.PostDefault(
      "/api/TienDoMau/DanhSachTheoDoiTienDoMau",
      request,
      context,
    );

    final parsed = TheoDoiTienDoMauModel.fromJson(response);

    _items = parsed.data ?? [];
    isLoading = false;
    notifyListeners();
  }
}
