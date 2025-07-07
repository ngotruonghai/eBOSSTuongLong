import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eboss_tuonglong/model/SanXuatSanPham/chitietgiaohangmaumodel.dart'
    as modelchititietgiaohangmau;
import 'package:eboss_tuonglong/model/SanXuatSanPham/chitietnhapkhomodel.dart'
    as modelchititietnhapkho;
import 'package:eboss_tuonglong/provider/danhsachsanphamprovider.dart';

class ChiTietDanhsachSanphamSreecn extends StatelessWidget {
  final String sampleID;
  const ChiTietDanhsachSanphamSreecn({super.key, required this.sampleID});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = ChiTietSanPhamProvider();
        provider.LoadData(context, sampleID);
        return provider;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF1F615C),
            title: const Text("Chi tiết tiến độ sản xuất"),
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: "Chi tiết giao hàng"),
                Tab(text: "Chi tiết nhập kho"),
              ],
            ),
          ),
          body: Consumer<ChiTietSanPhamProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return TabBarView(
                children: [
                  _buildTableGiaoHangMau(provider.chitietgiaohangmau),
                  _buildTableNhapKho(provider.chitietnhapkho),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTableGiaoHangMau(List<modelchititietgiaohangmau.Data?> data) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FixedColumnWidth(120),
            1: FixedColumnWidth(120),
            2: FixedColumnWidth(120),
            3: FixedColumnWidth(120),
            4: FixedColumnWidth(80),
            5: FixedColumnWidth(80),
            6: FixedColumnWidth(80),
            7: FixedColumnWidth(80),
            8: FixedColumnWidth(150),
            9: FixedColumnWidth(120),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[300]),
              children: [
                _buildTableCell("Số phiếu", isHeader: true),
                _buildTableCell("Ngày ghi nhận", isHeader: true),
                _buildTableCell("Mã sản phẩm", isHeader: true),
                _buildTableCell("Tên sản phẩm", isHeader: true),
                _buildTableCell("Đẳng cấp", isHeader: true),
                _buildTableCell("Đơn vị tính", isHeader: true),
                _buildTableCell("Số lượng", isHeader: true),
                _buildTableCell("ĐVT (giao dịch)", isHeader: true),
                _buildTableCell("SL (giao dịch)", isHeader: true),
                _buildTableCell("Ghi chú", isHeader: true),
              ],
            ),
            for (var item in data)
              TableRow(
                children: [
                  _buildTableCell(item?.deliveryID),
                  _buildTableCell(item?.recordDate),
                  _buildTableCell(item?.productID),
                  _buildTableCell(item?.productName),
                  _buildTableCell(item?.productType),
                  _buildTableCell(item?.unitID),
                  _buildTableCell(item?.qty?.toString()),
                  _buildTableCell(item?.dealUnitID),
                  _buildTableCell(item?.dealQty?.toString()),
                  _buildTableCell(item?.remark),                  
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableNhapKho(List<modelchititietnhapkho.Data?> data) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(),
          columnWidths: const {
             0: FixedColumnWidth(120),
            1: FixedColumnWidth(120),
            2: FixedColumnWidth(120),
            3: FixedColumnWidth(120),
            4: FixedColumnWidth(80),
            5: FixedColumnWidth(80),
            6: FixedColumnWidth(80),
            7: FixedColumnWidth(80),
            8: FixedColumnWidth(150),
            9: FixedColumnWidth(120),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[300]),
              children: [
               _buildTableCell2("Số phiếu", isHeader: true),
                _buildTableCell2("Ngày ghi nhận", isHeader: true),
                _buildTableCell2("Mã sản phẩm", isHeader: true),
                _buildTableCell2("Tên sản phẩm", isHeader: true),
                _buildTableCell2("Đẳng cấp", isHeader: true),
                _buildTableCell2("Đơn vị tính", isHeader: true),
                _buildTableCell2("Số lượng", isHeader: true),
                _buildTableCell2("Ghi chú", isHeader: true),
              ],
            ),
            for (var item in data)
              TableRow(
                children: [
                   _buildTableCell2(item?.stockID),
                  _buildTableCell2(item?.recordDate),
                  _buildTableCell2(item?.productID),
                  _buildTableCell2(item?.productName),
                  _buildTableCell2(item?.productType),
                  _buildTableCell2(item?.unitID),
                  _buildTableCell2(item?.qty?.toString()),
                  _buildTableCell(item?.remark),          
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCell(String? text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text ?? "",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }
  Widget _buildTableCell2(String? text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text ?? "",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }
}

class ChiTietSanPhamProvider extends ChangeNotifier {
  List<modelchititietgiaohangmau.Data> chitietgiaohangmau = [];
  List<modelchititietnhapkho.Data> chitietnhapkho = [];
  bool isLoading = false;

  Future<void> LoadData(BuildContext context, String sampleAID) async {
    isLoading = true;
    notifyListeners();
    await Future.wait([
      loadChiTietGiaoHangMau(context, sampleAID),
      loadChiTietNhapKho(context, sampleAID),
    ]);
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadChiTietGiaoHangMau(BuildContext context, String sampleAID) async {
    final response = await NetWorkRequest.GetDefault(
      "/api/SalesDeliverySampleProgress/ChiTietGiaoHang?SampleAID=$sampleAID",
      context,
    );
    final parsed = modelchititietgiaohangmau.ChiTietGiaoHangMauModel.fromJson(response);
    chitietgiaohangmau = parsed.data ?? [];
  }

  Future<void> loadChiTietNhapKho(BuildContext context, String sampleAID) async {
    final response = await NetWorkRequest.GetDefault(
      "/api/SalesDeliverySampleProgress/ChiTietNhapKho?SampleAID=$sampleAID",
      context,
    );
    final parsed = modelchititietnhapkho.ChiTietNhapKhoModel.fromJson(response);
    chitietnhapkho = parsed.data ?? [];
  }
}
