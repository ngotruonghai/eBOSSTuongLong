import 'package:eboss_tuonglong/model/TienDoXuLyMau/tiendoxulymaumodel.dart';
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';

class TienDoXuLyMauProvider with ChangeNotifier {
  List<Data> _items = [];
  bool isLoading = true;

  List<Data> get items => _items;
  Future<void> LoadDanhSachTienDoXuLyMau(
    BuildContext context,
    String fromDate,
    String toDate,
    String processID,
    String productID,
    String customerAID,
    String salesManAID,
  ) async {
    Map<String, dynamic> request = {
      "fromDate": fromDate,
      "toDate": toDate,
      "processID": processID,
      "productID": productID,
      "customerAID": customerAID,
      "salesManAID": salesManAID,
    };

    final response = await NetWorkRequest.PostDefault(
      "/api/SalesDeliverySampleProgress/TheoDoiTienDoXuLyMau",
      request,
      context,
    );

    final parsed = TienDoXuLyMauModel.fromJson(response);

    _items = parsed.data ?? [];
    isLoading = false;
    notifyListeners();
  }
}
