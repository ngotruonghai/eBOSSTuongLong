import 'package:eboss_tuonglong/model/SanXuatSanPham/danhsachsanphamModel.dart';
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';
import 'package:eboss_tuonglong/model/SanXuatSanPham/chitietgiaohangmaumodel.dart'
    as modelchititietgiaohangmau;
import 'package:eboss_tuonglong/model/SanXuatSanPham/chitietnhapkhomodel.dart'
    as modelchititietnhapkho;

class Danhsachsanphamprovider with ChangeNotifier {
  List<Data> _items = [];
  bool isLoading = true;

  List<Data> get items => _items;

  Future<void> LoadData(
    BuildContext context,
    String sampleID,
    String tungay,
    String denNgay,
  ) async {
    isLoading = true;
    //await Future.delayed(const Duration(seconds: 2)); // mô phỏng loading

    Map<String, dynamic> request = {
      "tuNgay": tungay,
      "denNgay": denNgay,
      "sampleID": sampleID,
    };

    final response = await NetWorkRequest.PostDefault(
      "/api/SalesDeliverySampleProgress/DanhSachSanPhamMau",
      request,
      context,
    );

    final parsed = DanhSachSanPhamModel.fromJson(response);

    _items = parsed.data ?? [];
    isLoading = false;
    notifyListeners();
  }
}

class ChiTietSanPhamProvider with ChangeNotifier {

  List<modelchititietgiaohangmau.Data?> _chitietgiaohangmau = [];
  List<modelchititietnhapkho.Data?> _chitietnhapkho = [];

  List<modelchititietgiaohangmau.Data?> get chitietgiaohangmau => _chitietgiaohangmau;
  List<modelchititietnhapkho.Data?> get chitietnhapkho => _chitietnhapkho;

  Future<void> LoadData(
    BuildContext context,
    String sampleID,
  ) async {
    // Load data for chitietgiaohangmau
    final response1 = await NetWorkRequest.GetDefault(
      "/api/SalesDeliverySampleProgress/ChiTietGiaohangmau?SampleID=$sampleID",
      context,
    );
       final parsed1  = modelchititietgiaohangmau.ChiTietGiaoHangMauModel.fromJson(response1);
       _chitietgiaohangmau =  parsed1.data ?? [];

    // Load data for chitietnhapkho
    final response2 = await NetWorkRequest.GetDefault(
      "/api/SalesDeliverySampleProgress/ChiTietNhapkho?SampleID=$sampleID",
      context,
    );
    final parsed2 = modelchititietnhapkho.ChiTietNhapKhoModel.fromJson(response2);
    _chitietnhapkho = parsed2.data ?? [];

    notifyListeners();
  }
}
