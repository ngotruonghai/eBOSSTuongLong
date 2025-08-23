import 'package:eboss_tuonglong/model/TienDoSanXuat/theodoitiendoxulymaumodel.dart';
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class TheoDoiTienDoXuLyMauProvider with ChangeNotifier {
  List<Data> _items = [];
  bool isLoading = true;

  List<Data> get items => _items;
  Future<void> LoadDanhSachTheoDoiTienDo(
    BuildContext context,
    String fromDate,
    String toDate,
  ) async {
    Map<String, dynamic> request = {
      "fromDate": fromDate,
      "toDate": toDate,
    };

    final response = await NetWorkRequest.PostDefault(
      "/api/TienDoMau/DanhSachTheoDoiTienDoMau",
      request,
      context,
    );

    final parsed = TheoDoiTienDoXuLyMauModel.fromJson(response);

    _items = parsed.data ?? [];
    isLoading = false;
    notifyListeners();
  }
}
