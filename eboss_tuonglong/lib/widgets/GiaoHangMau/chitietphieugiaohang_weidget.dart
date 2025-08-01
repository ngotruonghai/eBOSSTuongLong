import 'package:eboss_tuonglong/Access/mobilelanguageprovider.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';
import 'package:eboss_tuonglong/common/loadingoverlay.dart';
import 'package:eboss_tuonglong/common/snackbarerror.dart';
import 'package:eboss_tuonglong/model/PhieuMuaHang/chitietphieumuahangmodel.dart'
    as modelchitietphieumuahangs;
import 'package:eboss_tuonglong/model/PhieuMuaHang/danhsachchitietphieugiaohangmodel.dart'
    as modeldanhsachchitietphieugiaohangs;
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';

class ChiTietPhieuGiaoHangWidget extends StatefulWidget {
  final String id;
  final String deliveryAID;
  final String? salesManName;
  final String? maPhieu;
  final String? deliveryID;
  final String? customerName;

  const ChiTietPhieuGiaoHangWidget({
    Key? key,
    required this.id,
    required this.deliveryAID,
    required this.salesManName,
    required this.maPhieu,
    this.deliveryID,
    this.customerName,
  }) : super(key: key);

  @override
  State<ChiTietPhieuGiaoHangWidget> createState() =>
      _ChiTietPhieuGiaoHangWidgetState();
}

class _ChiTietPhieuGiaoHangWidgetState
    extends State<ChiTietPhieuGiaoHangWidget> {
  final _formKey = GlobalKey<FormState>();
  late List<modelchitietphieumuahangs.Data> lschitietphieumuahang = [];
  late List<modeldanhsachchitietphieugiaohangs.Data>
  lsdanhsachchitietphieumuahang = [];

  // Controllers
  final TextEditingController _soPhieuController = TextEditingController();
  final TextEditingController _loaiPhieuController = TextEditingController();
  final TextEditingController _ngayGhiNhanController = TextEditingController();
  final TextEditingController _tenKhachHangController = TextEditingController();
  final TextEditingController _nhanVienXuLyController = TextEditingController();
  final TextEditingController _nhanVienKinhDoanhController =
      TextEditingController();
  final TextEditingController _ngayTraLoiController = TextEditingController();
  final TextEditingController _yKienKhachHangController =
      TextEditingController();
  final TextEditingController _yKienLanhDaoController = TextEditingController();
  final TextEditingController _ghiChuController = TextEditingController();

  Future<int> API_LoadChiTietPhieuMuaHang(BuildContext context) async {
    Map<String, dynamic> request = {
      "thang": "",
      "nam": "",
      "deliveryAID": widget.id,
    };
    final response = await NetWorkRequest.PostDefault(
      "/api/PhieuGiaoHang/DanhSachPhieuMuaHang",
      request,
      context,
    );
    final parsedResponse = modelchitietphieumuahangs
        .ChiTietPhieuMuaHangModel.fromJson(response);
    lschitietphieumuahang = parsedResponse.data ?? [];
    return 1;
  }

  Future<int> API_LoadChiTietDanhSachPhieuMuaHang(BuildContext context) async {
    final response = await NetWorkRequest.GetDefault(
      "/api/PhieuGiaoHang/DanhSachChiTietPhieuGiaoHang?DeliveryAID=" +
          widget.id,
      context,
    );
    final parsedResponse = modeldanhsachchitietphieugiaohangs
        .DanhSachChiTietPhieuGiaoHangModel.fromJson(response);
    lsdanhsachchitietphieumuahang = parsedResponse.data ?? [];
    return 1;
  }

  Future<int> API_AddYKienPhieuMuaHan(BuildContext context) async {
    Map<String, dynamic> request = {
      "yKienKhachHang": _yKienKhachHangController.text,
      "yienLanhDao": _yKienLanhDaoController.text,
      "ghiChu": _ghiChuController.text,
      "deliveryAID": widget.id,
      "salesManName": widget.salesManName?.trim() ?? "",
      "maPhieu" : widget.maPhieu?.trim() ?? "",
      "deliveryID": widget.deliveryID?.trim() ?? "",
      "customerName": widget.customerName?.trim() ?? "",
    };
    final response = await NetWorkRequest.PutDefault(
      "/api/PhieuGiaoHang/CapNhatYKien",
      request,
      context,
    );
    final parsedResponse = modelchitietphieumuahangs
        .ChiTietPhieuMuaHangModel.fromJson(response);
    lschitietphieumuahang = parsedResponse.data ?? [];
    return 1;
  }

  Future<bool> loadData(BuildContext context) async {
    try {
      await API_LoadChiTietPhieuMuaHang(context);
      await API_LoadChiTietDanhSachPhieuMuaHang(context);
      final firstItem = lschitietphieumuahang[0];
      _soPhieuController.text = firstItem.deliveryID ?? "";
      _ghiChuController.text = firstItem.remark ?? "";
      _yKienKhachHangController.text = firstItem.yKienKhachHang ?? "";
      _yKienLanhDaoController.text = firstItem.yKienLanhDao ?? "";
      _tenKhachHangController.text = firstItem.tenKhachHang ?? "";
      _nhanVienXuLyController.text = firstItem.nhanVienXuLy ?? "";
      _nhanVienKinhDoanhController.text = firstItem.nhanVienKinhDoanh ?? "";
      _ngayTraLoiController.text = firstItem.ngayDuKienTraLoi ?? "";
      _ngayGhiNhanController.text = firstItem.recordDate ?? "";
      _loaiPhieuController.text = firstItem.loaiPhieu??"";
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
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [Tab(text: LoadAppMobileLanguage.GetStringLanguage("thongtinchung", NameDefault: "Thông tin chung")),
             Tab(text: LoadAppMobileLanguage.GetStringLanguage("chitiet", NameDefault: "Chi tiết"))],
          ),
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
                return TabBarView(
                  children: [_buildThongTinChung(), _buildChiTiet()],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // Tab "Thông tin chung"
  Widget _buildThongTinChung() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [ 
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _buildReadOnlyTextField(LoadAppMobileLanguage.GetStringLanguage("sophieu", NameDefault: "Số phiếu giao"), _soPhieuController, true),
            ),                       
            _buildReadOnlyTextField(LoadAppMobileLanguage.GetStringLanguage("loaiphieu", NameDefault: "Loại phiếu"), _loaiPhieuController, true),
            _buildReadOnlyTextField(
              LoadAppMobileLanguage.GetStringLanguage("13", NameDefault: "Ngày ghi nhận"),
              _ngayGhiNhanController,
              true,
            ),
            _buildReadOnlyTextField(
              LoadAppMobileLanguage.GetStringLanguage("tenkhachhang", NameDefault: "Tên khách hàng"),
              _tenKhachHangController,
              true,
            ),
            _buildReadOnlyTextField(
              LoadAppMobileLanguage.GetStringLanguage("nhanvienxuly", NameDefault: "Nhân viên xử lý"),
              _nhanVienXuLyController,
              true,
            ),
            _buildReadOnlyTextField(
              LoadAppMobileLanguage.GetStringLanguage("16", NameDefault: "Nhân viên kinh doanh"),
              _nhanVienKinhDoanhController,
              true,
            ),
            _buildReadOnlyTextField(
              LoadAppMobileLanguage.GetStringLanguage("12", NameDefault: "Ngày dự kiến trả lời"),
              _ngayTraLoiController,
              true,
            ),
            _buildReadOnlyTextField(
              LoadAppMobileLanguage.GetStringLanguage("36", NameDefault: "Ý kiến khách hàng"),
              _yKienKhachHangController,
              false,
            ),
            _buildReadOnlyTextField(
              LoadAppMobileLanguage.GetStringLanguage("37", NameDefault: "Ý kiến ban lãnh đạo"),
              _yKienLanhDaoController,
              false,
            ),
            _buildReadOnlyTextField(
              LoadAppMobileLanguage.GetStringLanguage("ghichu", NameDefault: "Ghi chú"),
              _ghiChuController,
              false,
            ),
            ElevatedButton(
              onPressed: () async {
                // Xử lý khi bấm nút
                LoadingOverlay.show(context);
                await API_AddYKienPhieuMuaHan(context);
                LoadingOverlay.hide(context);
                SnackbarError.showSnackbar_Succes(
                  context,
                  message: 'Lưu thành công',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1F615C), // Màu nền xanh lá
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Bo tròn góc
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
              ),
              child: 
              LanguageText(
                nameId: "luuthongtin",
                defaultValue: "Lưu thông tin",
                style: TextStyle(color: Colors.white, fontSize: 16)
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tab "Chi tiết"
  Widget _buildChiTiet() {
    return SingleChildScrollView(
      scrollDirection:Axis.vertical,
      child: SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Cuộn ngang nếu cần
      child: Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FixedColumnWidth(80), // Cột "Mã hàng"
          1: FixedColumnWidth(180), // Cột "Tên sản phẩm"
          2: FixedColumnWidth(80), // Cột "Đơn vị tính"
          3: FixedColumnWidth(60), // Cột "Số lượng"
          4: FixedColumnWidth(150), // Cột "Ghi chú"
        },
        children: [
          _buildTableHeader(),
          for (var item in lsdanhsachchitietphieumuahang) _buildTableRow(item),
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
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("9", NameDefault: "Mã hàng"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("tensanpham", NameDefault: "Tên sản phẩm"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("donvitinh", NameDefault: "Đơn vị tính"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("soluong", NameDefault: "Số lượng"), isHeader: true),
        _buildTableCell(LoadAppMobileLanguage.GetStringLanguage("ghichu", NameDefault: "Ghi chú"), isHeader: true),
      ],
    );
  }

  // Hàng dữ liệu
  TableRow _buildTableRow(modeldanhsachchitietphieugiaohangs.Data item) {
    return TableRow(
      children: [
        _buildTableCell(item.maHang),
        _buildTableCell(item.tenSanPham),
        _buildTableCell(item.donViTinh),
        _buildTableCell(item.soLuong?.toString()),
        _buildTableCell(item.ghiChu),
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
