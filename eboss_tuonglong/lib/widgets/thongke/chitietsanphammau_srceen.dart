import 'package:eboss_tuonglong/Access/mobilelanguageprovider.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';
import 'package:eboss_tuonglong/common/loadingoverlay.dart';
import 'package:eboss_tuonglong/common/snackbarerror.dart';
import 'package:eboss_tuonglong/model/SanXuatSanPham/chitietgiaohangpermission.dart';
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';
import 'package:eboss_tuonglong/Access/functionApp.dart';

class ChiTietPhieuGiaoHangMauSrceen extends StatefulWidget {
  final String id;
  final String deliveryAID;

  const ChiTietPhieuGiaoHangMauSrceen({
    Key? key,
    required this.id,
    required this.deliveryAID,
  }) : super(key: key);

  @override
  State<ChiTietPhieuGiaoHangMauSrceen> createState() =>
      _ChiTietPhieuGiaoHangMauSrceenState();
}

class _ChiTietPhieuGiaoHangMauSrceenState
    extends State<ChiTietPhieuGiaoHangMauSrceen> {
  late List<Data> lschitietphieumuahang = [];
  late List<Data> lsdanhsachchitietphieumuahang = [];

  Future<int> API_LoadChiTietDanhSachPhieuMuaHang(BuildContext context) async {
    final response = await NetWorkRequest.GetDefault(
      "/api/PhieuGiaoHang/DanhSachChiTietPhieuGiaoHangPermission?DeliveryAID=" +
          widget.deliveryAID,
      context,
    );
    final parsedResponse = ChiTietGiaoHangPermissionModel.fromJson(response);
    lsdanhsachchitietphieumuahang = parsedResponse.data ?? [];
    return 1;
  }

  Future<bool> loadData(BuildContext context) async {
    try {
      await API_LoadChiTietDanhSachPhieuMuaHang(context);
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
      length: 2, // Số lượng tab
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1F615C),
          title: LanguageText(nameId: "chitietphieugiaohang", defaultValue: "Chi tiết phiếu giao hàng"),
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
          5: FixedColumnWidth(120),
          6: FixedColumnWidth(120),
          7: FixedColumnWidth(120),
          8: FixedColumnWidth(120),
          9: FixedColumnWidth(120),
          10: FixedColumnWidth(120),
          11: FixedColumnWidth(120),
           12: FixedColumnWidth(120),
        },
        children: [
          _buildTableHeader(),
          if (lsdanhsachchitietphieumuahang.isEmpty)
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
                for (int i = 0; i < 4; i++)
                  SizedBox.shrink(),
              ],
            ),
          for (var item in lsdanhsachchitietphieumuahang)
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
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("sophieuyeucau", NameDefault: "Số phiếu yêu cầu"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("masanpham", NameDefault: "Mã sản phẩm"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("tensanpham", NameDefault: "Tên sản phẩm"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("dangcap", NameDefault: "Đẳng cấp"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("donvitinh", NameDefault: "Đơn vị tính"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("soluong", NameDefault: "SL"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("dvtgiaodich", NameDefault: "ĐVT giao dịch"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("slgiaodich", NameDefault: "SL giao dịch"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("dongia", NameDefault: "Đơn giá VNĐ"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("thanhtien", NameDefault: "Thành tiền VNĐ"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("gianhap", NameDefault: "Giá nhập"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("ghichu", NameDefault: "Ghi chú"), isHeader: true),
      ],
    );
  }

  // Hàng dữ liệu
  TableRow _buildTableRow(Data item) {
    return TableRow(
      children: [
        _buildTableCell(item.SampleID??""),
        _buildTableCell(item.productID??""),
        _buildTableCell(item.GeneralName??""),
        _buildTableCell(item.productType??""),
        _buildTableCell(item.TenDonVi??""),
        _buildTableCell(item.dealQty?.toString()??""),
        _buildTableCell(item.TenDonVi??""),
         _buildTableCell(item.qty?.toString()??""),
        _buildTableCell( AppFormatter.formatCurrencyInt(item.price).replaceAll('.', ',')),

        _buildTableCell(AppFormatter.formatCurrencyDo(item.amount).replaceAll('.', ',')),
        
        _buildTableCell(AppFormatter.formatCurrencyInt(item.inPrice).replaceAll('.', ',')),
        _buildTableCell((item.remark??"").toString()),
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
