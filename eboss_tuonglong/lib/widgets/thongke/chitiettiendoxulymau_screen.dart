import 'package:eboss_tuonglong/Access/mobilelanguageprovider.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';
import 'package:eboss_tuonglong/model/TienDoXuLyMau/chitietgiaohangmau.dart';
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';
import 'package:eboss_tuonglong/Access/functionApp.dart';

class ChiTietTienDoXuLyMauScreen extends StatefulWidget {
  final String id;
  final String processAID;

  const ChiTietTienDoXuLyMauScreen({
    Key? key,
    required this.id,
    required this.processAID,
  }) : super(key: key);

  @override
  State<ChiTietTienDoXuLyMauScreen> createState() =>
      _ChiTietTienDoXuLyMauScreen();
}

class _ChiTietTienDoXuLyMauScreen
    extends State<ChiTietTienDoXuLyMauScreen> {
  late List<Data> lsdanhsachchitietgiaohangmau = [];

  Future<int> API_LoadChiTiet(BuildContext context) async {
    final response = await NetWorkRequest.GetDefault(
      "/api/SalesDeliverySampleProgress/ChiTietTheoDoiTienDoXuLyMau/ProcessAID=" +
          widget.processAID,
      context,
    );
    final parsedResponse = ChiTietGiaoHangMauModel.fromJson(response);
    lsdanhsachchitietgiaohangmau = parsedResponse.data ?? [];
    return 1;
  }

  Future<bool> loadData(BuildContext context) async {
    try {
      await API_LoadChiTiet(context);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _refreshData() async {
    await loadData(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1, // Số lượng tab
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1F615C),
          title: LanguageText(nameId: "ChiTietGiaoHangMau", defaultValue: "Chi tiết giao hàng mẫu"),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: FutureBuilder<bool>(
            future: loadData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: Color(0xFF1F615C)),
                );
              } else {
                return _buildChiTiet();
              }
            },
          ),
        ),
      ),
    );
  }

  // Tab "Chi tiết"
  Widget _buildChiTiet() {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FixedColumnWidth(120),
          1: FixedColumnWidth(120),
          2: FixedColumnWidth(120),
          3: FixedColumnWidth(120),
          4: FixedColumnWidth(120),
          5: FixedColumnWidth(80),
          6: FixedColumnWidth(80),
          7: FixedColumnWidth(120),
          8: FixedColumnWidth(120),
          9: FixedColumnWidth(120),
        },
        children: [
          _buildTableHeader(),
          if (lsdanhsachchitietgiaohangmau.isEmpty)
            TableRow(
              children: [
                TableCell(
                  // colspan không hỗ trợ trực tiếp, dùng 1 ô và bỏ border các ô còn lại nếu muốn đẹp hơn
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: LanguageText(nameId: "nodata", defaultValue: "Không có dữ liệu", style: TextStyle(fontSize: 16, color: Colors.grey))
                    ),
                  ),    
                ),
                for (int i = 0; i < 9; i++)
                  SizedBox.shrink(),
              ],
            ),
          for (var item in lsdanhsachchitietgiaohangmau)
            _buildTableRow(item),
        ],
      ),
    ),
  );
}

  // Tiêu đề bảng
  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey[300]),
      children: [
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("VoucherID", NameDefault: "Số phiếu"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("13", NameDefault: "Ngày ghi nhận"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("masanpham", NameDefault: "Mã sản phẩm"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("tensanpham", NameDefault: "Tên sản phẩm"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("ProductType", NameDefault: "Đẳng cấp"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("donvitinh", NameDefault: "Đơn vị tính"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("soluong", NameDefault: "SL"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("dvtgiaodich", NameDefault: "ĐVT (Giao dịch)"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("slgiaodich", NameDefault: "SL (Giao dịch)"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("ghichu", NameDefault: "Ghi chú"), isHeader: true),
      ],
    );
  }

  // Hàng dữ liệu
  TableRow _buildTableRow(Data item) {
    return TableRow(
      children: [
        _buildTableCell(item.deliveryID??""),
        _buildTableCell(item.recordDate??""),
        _buildTableCell(item.productID??""),
        _buildTableCell(item.productName??""),
        _buildTableCell(item.productTypeName??""),
        _buildTableCell(item.unitName??""),
        _buildTableCell(item.qty??""),
        _buildTableCell(item.dealUnitName??""),
        _buildTableCell(item.dealQty??""),
        _buildTableCell(item.remark??""),
      ],
    );
  }

  // Ô trong bảng
  Widget _buildTableCell(String? text, {bool isHeader = false}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
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

  // Hàm tạo TextField chỉ đọc và tự động xuống dòng
  Widget _buildReadOnlyTextField(
    String label,
    TextEditingController controller,
    bool readOnly,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
