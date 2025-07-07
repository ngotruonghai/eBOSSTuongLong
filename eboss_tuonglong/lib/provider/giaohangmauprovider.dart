import 'package:eboss_tuonglong/model/PhieuMuaHang/danhsachphieumuahangmodel.dart';
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class GiaoHangMauProvider with ChangeNotifier {
  List<Data> _items = [];
  bool isLoading = true;

  List<Data> get items => _items;

  Future<void> LoadDataDanhSachPhanQuyenPhieuGiaoHanh(
    BuildContext context,String deliveryID, String deliveryAID, String tenKhachHang, String nhanVienKinhDoanh,String tungay,String denNgay) async {
    isLoading = true;
    //await Future.delayed(const Duration(seconds: 2)); // mô phỏng loading

    Map<String, dynamic> request = {
      "tuNgay": tungay,
      "denNgay":  denNgay,
      "deliveryID": deliveryID,
      "deliveryAID": deliveryAID,
      "tenKhachHang": tenKhachHang,
      "nhanVienKinhDoanh":  nhanVienKinhDoanh,
    };

    final response = await NetWorkRequest.PostDefault(
      "/api/PhieuGiaoHang/DanhSachPhieuGiaoHangPermission",
      request,
      context,
    );

    final parsed = DanhSachPhieuMuaHangModel.fromJson(response);

    _items = parsed.data ?? [];
    isLoading = false;
    notifyListeners();
  }

  Future<void> LoadDataDanhSachPhanQuyenPhieuGiaoHanh2(
    BuildContext context,
  ) async {
    isLoading = true;
    //await Future.delayed(const Duration(seconds: 2)); // mô phỏng loading

    Map<String, dynamic> request = {
      "tuNgay": "",
      "denNgay": "",
      "deliveryID": "dsads",
      "deliveryAID": "",
      "tenKhachHang": "",
      "nhanVienKinhDoanh": "",
    };

    final response = await NetWorkRequest.PostDefault(
      "/api/PhieuGiaoHang/DanhSachPhieuGiaoHangPermission",
      request,
      context,
    );

    final parsed = DanhSachPhieuMuaHangModel.fromJson(response);

    _items = parsed.data ?? [];
    isLoading = false;
    notifyListeners();
  }
}



class GiaoHangMau {
  final int id;
  final String tenKhachHang;

  GiaoHangMau({required this.id, required this.tenKhachHang});
}
