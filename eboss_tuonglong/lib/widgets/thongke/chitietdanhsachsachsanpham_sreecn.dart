import 'package:eboss_tuonglong/Access/mobilelanguageprovider.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eboss_tuonglong/model/SanXuatSanPham/chitietgiaohangmaumodel.dart'
    as modelchititietgiaohangmau;
import 'package:eboss_tuonglong/model/SanXuatSanPham/chitietnhapkhomodel.dart'
    as modelchititietnhapkho;
import 'package:eboss_tuonglong/provider/danhsachsanphamprovider.dart';
import '../../model/SanXuatSanPham/ChiTietYeuCauModel.dart'
    as modelChiTietYeuCau;
import '../../model/SanXuatSanPham/ChiTietXuLyHangMauModel.dart'
    as modelChiTietXuLyHangMau;

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
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF1F615C),
            title: LanguageText(nameId: "chitiettiendosanxuat", defaultValue: "Chi tiết tiến độ sản xuất"),
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            bottom:  TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: LoadAppMobileLanguage.GetStringLanguage("ChiTietYeuCau", NameDefault: "Chi tiết yêu cầu")),
                Tab(text: LoadAppMobileLanguage.GetStringLanguage("chitietgiaohang", NameDefault: "Chi tiết giao hàng")),
                Tab(text: LoadAppMobileLanguage.GetStringLanguage("chitietnhapkho", NameDefault: "Chi tiết nhập kho")),
                Tab(text: LoadAppMobileLanguage.GetStringLanguage("ChiTietXuLyHangMau", NameDefault: "Chi tiết xử lý hàng mẫu")),
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
                  _buildTableYeuCau(provider.chitietyeucau),
                  _buildTableGiaoHangMau(provider.chitietgiaohangmau),
                  _buildTableNhapKho(provider.chitietnhapkho),
                  _buildTableXuLyHangMau(provider.chitietxulyhangmau)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTableYeuCau(List<modelChiTietYeuCau.Data?> data) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FixedColumnWidth(80),
            1: FixedColumnWidth(120),
            2: FixedColumnWidth(250),
            3: FixedColumnWidth(120),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[300]),
              children: [
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("InOrder", NameDefault: "STT"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("CategoriesID", NameDefault: "Hạng mục"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("Description", NameDefault: "Nội dung"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("ghichu", NameDefault: "Ghi chú"), isHeader: true),
              ],
            ),
            for (var item in data)
              TableRow(
                children: [
                  _buildTableCell(item?.inOrder),
                  _buildTableCell(item?.categoriesName),
                  _buildTableCell(item?.description),
                  _buildTableCell(item?.remark),               
                ],
              ),
          ],
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
            4: FixedColumnWidth(120),
            5: FixedColumnWidth(120),
            6: FixedColumnWidth(120),
            7: FixedColumnWidth(120),
            8: FixedColumnWidth(120),
            9: FixedColumnWidth(120),
            10: FixedColumnWidth(80),
            11: FixedColumnWidth(80),
            12: FixedColumnWidth(80),
            13: FixedColumnWidth(80),
            14: FixedColumnWidth(80),
            15: FixedColumnWidth(120),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[300]),
              children: [
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("sophieuyeucau", NameDefault: "Số phiếu yêu cầu"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("13", NameDefault: "Ngày ghi nhận"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("tenkhachhang", NameDefault: "Tên khách hàng"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("16", NameDefault: "Nhân viên kinh doanh"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("12", NameDefault: "Ngày dự kiến trả lời"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("36", NameDefault: "Ý kiến khách hàng"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("37", NameDefault: "Ý kiến ban lãnh đạo"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("ResponseDay", NameDefault: "Số ngày KH phản hồi ý kiến"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("masanpham", NameDefault: "Mã sản phẩm"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("tensanpham", NameDefault: "Tên sản phẩm"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("dangcap", NameDefault: "Đẳng cấp"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("donvitinh", NameDefault: "Đơn vị tính"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("soluong", NameDefault: "Số lượng"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("dvtgiaodich", NameDefault: "ĐVT (giao dịch)"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("slgiaodich", NameDefault: "SL (giao dịch)"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("ghichu", NameDefault: "Ghi chú"), isHeader: true),
              ],
            ),
            for (var item in data)
              TableRow(
                children: [
                  _buildTableCell(item?.deliveryID),
                  _buildTableCell(item?.recordDate),
                  _buildTableCell(item?.customerName),
                  _buildTableCell(item?.salesManName),
                  _buildTableCell(item?.responseDate),
                  _buildTableCell(item?.commentsCustomer),
                  _buildTableCell(item?.commentsManagement),
                  _buildTableCell(item?.responseDay),
                  _buildTableCell(item?.productID),
                  _buildTableCell(item?.productName),
                  _buildTableCell(item?.productType),
                  _buildTableCell(item?.unitID),
                  _buildTableCell(item?.qty),
                  _buildTableCell(item?.dealUnitID),
                  _buildTableCell(item?.dealQty),
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
               _buildTableCell2(LoadAppMobileLanguage.GetStringLanguage("sophieu", NameDefault: "Số phiếu"), isHeader: true),
                _buildTableCell2(LoadAppMobileLanguage.GetStringLanguage("13", NameDefault: "Ngày ghi nhận"), isHeader: true),
                _buildTableCell2(LoadAppMobileLanguage.GetStringLanguage("masanpham", NameDefault: "Mã sản phẩm"), isHeader: true),
                _buildTableCell2(LoadAppMobileLanguage.GetStringLanguage("tensanpham", NameDefault: "Tên sản phẩm"), isHeader: true),
                _buildTableCell2(LoadAppMobileLanguage.GetStringLanguage("dangcap", NameDefault: "Đẳng cấp"), isHeader: true),
                _buildTableCell2(LoadAppMobileLanguage.GetStringLanguage("donvitinh", NameDefault: "Đơn vị tính"), isHeader: true),
                _buildTableCell2(LoadAppMobileLanguage.GetStringLanguage("soluong", NameDefault: "Số lượng"), isHeader: true),
                _buildTableCell2(LoadAppMobileLanguage.GetStringLanguage("ghichu", NameDefault: "Ghi chú"), isHeader: true),
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
                  _buildTableCell2(item?.qty),
                  _buildTableCell(item?.remark),          
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableXuLyHangMau(List<modelChiTietXuLyHangMau.Data?> data) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FixedColumnWidth(80),
            1: FixedColumnWidth(120),
            2: FixedColumnWidth(120),
            3: FixedColumnWidth(120),
            4: FixedColumnWidth(120),
            5: FixedColumnWidth(120),
            6: FixedColumnWidth(120),
            7: FixedColumnWidth(120),
            8: FixedColumnWidth(120),
            9: FixedColumnWidth(120),
            10: FixedColumnWidth(120),
            11: FixedColumnWidth(120),
            12: FixedColumnWidth(120),
            13: FixedColumnWidth(120),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[300]),
              children: [
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("VoucherID", NameDefault: "Số phiếu"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("13", NameDefault: "Ngày ghi nhận"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("masanpham", NameDefault: "Mã sản phẩm"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("HangerUnitID", NameDefault: "ĐVT Hanger"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("QtyHanger", NameDefault: "SL Hanger"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("TrousersUnitID", NameDefault: "ĐVT Quần"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("TrousersQty", NameDefault: "SL Quần"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("ShirtUnitID", NameDefault: "ĐVT Áo"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("ShirtQty", NameDefault: "SL Áo"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("tenkhachhang", NameDefault: "Tên khách hàng"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("16", NameDefault: "Nhân viên kinh doanh"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("SewingDate", NameDefault: "Ngày may"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("FactoryWashDate", NameDefault: "Ngày Wash xưởng"), isHeader: true),
                _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("SmartLabDate", NameDefault: "Ngày SmartLab"), isHeader: true),
              ],
            ),
            for (var item in data)
              TableRow(
                children: [
                  _buildTableCell(item?.processID),
                  _buildTableCell(item?.recordDate),
                  _buildTableCell(item?.productID),
                  _buildTableCell(item?.unitName),
                  _buildTableCell(item?.qty),
                  _buildTableCell(item?.trouserUnitName),
                  _buildTableCell(item?.trousersQty),
                  _buildTableCell(item?.shirtUnitName),
                  _buildTableCell(item?.shirtQty),
                  _buildTableCell(item?.customerName),
                  _buildTableCell(item?.salesManName),
                  _buildTableCell(item?.sewingDate),
                  _buildTableCell(item?.factoryWashDate),
                  _buildTableCell(item?.smartLabDate),
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
  List<modelChiTietYeuCau.Data> chitietyeucau = [];
  List<modelchititietgiaohangmau.Data> chitietgiaohangmau = [];
  List<modelchititietnhapkho.Data> chitietnhapkho = [];
  List<modelChiTietXuLyHangMau.Data> chitietxulyhangmau = [];
  bool isLoading = false;

  Future<void> LoadData(BuildContext context, String sampleAID) async {
    isLoading = true;
    notifyListeners();
    await Future.wait([
      loadChiTietYeuCau(context, sampleAID),
      loadChiTietGiaoHangMau(context, sampleAID),
      loadChiTietNhapKho(context, sampleAID),
      loadChiTietXuLyHangMau(context, sampleAID),
    ]);
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadChiTietYeuCau(BuildContext context, String sampleAID) async {
    final response = await NetWorkRequest.GetDefault(
      "/api/SalesDeliverySampleProgress/ChiTietYeuCau?SampleAID=$sampleAID",
      context,
    );
    final parsed = modelChiTietYeuCau.ChiTietYeuCauModel.fromJson(response);
    chitietyeucau = parsed.data ?? [];
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

  Future<void> loadChiTietXuLyHangMau(BuildContext context, String sampleAID) async {
    final response = await NetWorkRequest.GetDefault(
      "/api/SalesDeliverySampleProgress/ChiTietXuLyHangMau?SampleAID=$sampleAID",
      context,
    );
    final parsed = modelChiTietXuLyHangMau.ChiTietXulyHangMauModel.fromJson(response);
    chitietxulyhangmau = parsed.data ?? [];
  }
}
