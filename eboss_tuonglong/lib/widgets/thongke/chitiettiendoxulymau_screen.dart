import 'package:eboss_tuonglong/Access/mobilelanguageprovider.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';
import 'package:eboss_tuonglong/model/TienDoXuLyMau/chiTietNhapKhoHangMau_model.dart' as chiTietKhoHang;
import 'package:eboss_tuonglong/model/TienDoXuLyMau/chitietgiaohangmau.dart';
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';

class ChiTietTienDoXuLyMauScreen extends StatefulWidget {
  final String id;
  final String processAID;

  const ChiTietTienDoXuLyMauScreen({
    Key? key,
    required this.id,
    required this.processAID,
  }) : super(key: key);

  @override
  State<ChiTietTienDoXuLyMauScreen> createState() => _ChiTietTienDoXuLyMauScreenState();
}

class _ChiTietTienDoXuLyMauScreenState extends State<ChiTietTienDoXuLyMauScreen> {
  List<Data> lsdanhsachchitietgiaohangmau = [];
  List<chiTietKhoHang.Data> lsChiTietKhoHang = [];
  bool isLoading = false;

  // Define fixed column widths
  static const Map<int, TableColumnWidth> _deliveryColumnWidths = {
    0: FixedColumnWidth(120), // Số phiếu
    1: FixedColumnWidth(120), // Ngày ghi nhận
    2: FixedColumnWidth(120), // Mã sản phẩm
    3: FixedColumnWidth(180), // Tên sản phẩm (wider for longer names)
    4: FixedColumnWidth(100), // Đẳng cấp
    5: FixedColumnWidth(100), // Đơn vị tính
    6: FixedColumnWidth(80),  // SL
    7: FixedColumnWidth(120), // ĐVT (Giao dịch)
    8: FixedColumnWidth(100), // SL (Giao dịch)
    9: FixedColumnWidth(150), // Ghi chú
  };

  static const Map<int, TableColumnWidth> _warehouseColumnWidths = {
    0: FixedColumnWidth(120), // Mã kho
    1: FixedColumnWidth(120), // Ngày ghi nhận
    2: FixedColumnWidth(150), // Mô tả
    3: FixedColumnWidth(120), // Mã sản phẩm
    4: FixedColumnWidth(180), // Tên sản phẩm
    5: FixedColumnWidth(100), // Loại SP
    6: FixedColumnWidth(80),  // Đơn vị
    7: FixedColumnWidth(100), // Số lượng
    8: FixedColumnWidth(150), // Ghi chú
    9: FixedColumnWidth(120), // Process ID
  };

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1F615C),
          foregroundColor: Colors.white,
          title: const LanguageText(
              nameId: "ChiTietGiaoHangMau",
              defaultValue: "Chi tiết tiến độ xử lý mẫu"
          ),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(
                  text: LoadAppMobileLanguage.GetStringLanguage(
                      "ChiTietYeuCau",
                      NameDefault: "Giao hàng mẫu"
                  )
              ),
              Tab(
                text: LoadAppMobileLanguage.GetStringLanguage(
                  "chitietnhapkho",
                  NameDefault: "Nhập kho hàng mẫu nội bộ",
                ),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: isLoading
              ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF1F615C))
          )
              : TabBarView(
              children: [
                _buildChiTiet(),
                _buildChiTietKhoHang(),
              ]
          ),
        ),
      ),
    );
  }

  Widget _buildChiTiet() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          columnWidths: _deliveryColumnWidths,
          children: [
            _buildDeliveryTableHeader(),
            if (lsdanhsachchitietgiaohangmau.isEmpty)
              _buildNoDataTableRow(_deliveryColumnWidths.length),
            ...lsdanhsachchitietgiaohangmau.map((item) => _buildDeliveryTableRow(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildChiTietKhoHang() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          columnWidths: _warehouseColumnWidths,
          children: [
            _buildWarehouseTableHeader(),
            if (lsChiTietKhoHang.isEmpty)
              _buildNoDataTableRow(_warehouseColumnWidths.length),
            ...lsChiTietKhoHang.map((item) => _buildWarehouseTableRow(item)),
          ],
        ),
      ),
    );
  }

  TableRow _buildDeliveryTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey[300]),
      children: [
        _buildTableCell(
            LoadAppMobileLanguage.GetStringLanguage("VoucherID", NameDefault: "Số phiếu"),
            isHeader: true
        ),
        _buildTableCell(
            LoadAppMobileLanguage.GetStringLanguage("13", NameDefault: "Ngày ghi nhận"),
            isHeader: true
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("masanpham", NameDefault: "Mã sản phẩm"),
          isHeader: true,
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("tensanpham", NameDefault: "Tên sản phẩm"),
          isHeader: true,
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("ProductType", NameDefault: "Đẳng cấp"),
          isHeader: true,
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("donvitinh", NameDefault: "Đơn vị tính"),
          isHeader: true,
        ),
        _buildTableCell(
            LoadAppMobileLanguage.GetStringLanguage("soluong", NameDefault: "SL"),
            isHeader: true
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("dvtgiaodich", NameDefault: "ĐVT (Giao dịch)"),
          isHeader: true,
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("slgiaodich", NameDefault: "SL (Giao dịch)"),
          isHeader: true,
        ),
        _buildTableCell(
            LoadAppMobileLanguage.GetStringLanguage("ghichu", NameDefault: "Ghi chú"),
            isHeader: true
        ),
      ],
    );
  }

  TableRow _buildWarehouseTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey[300]),
      children: [
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("VoucherID", NameDefault: "Số phiếu"),
          isHeader: true,
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("13", NameDefault: "Ngày ghi nhận"),
          isHeader: true,
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("DienGiai", NameDefault: "Diễn giải"),
          isHeader: true,
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("masanpham", NameDefault: "Mã sản phẩm"),
          isHeader: true,
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("tensanpham", NameDefault: "Tên sản phẩm"),
          isHeader: true,
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("ProductType", NameDefault: "Đẳng cấp"),
          isHeader: true,
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("donvitinh", NameDefault: "Đơn vị tính"),
          isHeader: true,
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("soluong", NameDefault: "Số lượng"),
          isHeader: true,
        ),
        _buildTableCell(
          LoadAppMobileLanguage.GetStringLanguage("ghichu", NameDefault: "Ghi chú"),
          isHeader: true,
        ),
      ],
    );
  }

  TableRow _buildDeliveryTableRow(Data item) {
    return TableRow(
      children: [
        _buildTableCell(item.deliveryID ?? ""),
        _buildTableCell(item.recordDate ?? ""),
        _buildTableCell(item.productID ?? ""),
        _buildTableCell(item.productName ?? ""),
        _buildTableCell(item.productTypeName ?? ""),
        _buildTableCell(item.unitName ?? ""),
        _buildTableCell(item.qty ?? ""),
        _buildTableCell(item.dealUnitName ?? ""),
        _buildTableCell(item.dealQty ?? ""),
        _buildTableCell(item.remark ?? ""),
      ],
    );
  }

  TableRow _buildWarehouseTableRow(chiTietKhoHang.Data item) {
    return TableRow(
      children: [
        _buildTableCell(item.stockID ?? ""),
        _buildTableCell(item.recordDate ?? ""),
        _buildTableCell(item.description ?? ""),
        _buildTableCell(item.productID ?? ""),
        _buildTableCell(item.productName ?? ""),
        _buildTableCell(item.productType ?? ""),
        _buildTableCell(item.unitName ?? ""),
        _buildTableCell(item.qty ?? ""),
        _buildTableCell(item.remark ?? ""),
      ],
    );
  }

  TableRow _buildNoDataTableRow(int columnCount) {
    return TableRow(
      children: [
        TableCell(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Center(
              child: LanguageText(
                nameId: "nodata",
                defaultValue: "Không có dữ liệu",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
        ),
        for (int i = 1; i < columnCount; i++)
          const TableCell(child: SizedBox.shrink()),
      ],
    );
  }

  Widget _buildTableCell(String? text, {bool isHeader = false}) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              fontSize: 14
          ),
          // Cho phép text wrap trong fixed width columns
          overflow: TextOverflow.visible,
          softWrap: true,
        ),
      ),
    );
  }

  Future<void> _loadChiTietGiaoHang() async {
    try {
      final response = await NetWorkRequest.GetDefault(
        "/api/SalesDeliverySampleProgress/ChiTietTheoDoiTienDoXuLyMau/ProcessAID=${widget.processAID}",
        context,
      );
      final parsedResponse = ChiTietGiaoHangMauModel.fromJson(response);
      lsdanhsachchitietgiaohangmau = parsedResponse.data ?? [];
    } catch (e) {
      debugPrint('Error loading chi tiet giao hang: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lỗi khi tải dữ liệu giao hàng')),
        );
      }
    }
  }

  Future<void> _loadChiTietKhoHang() async {
    try {
      final response = await NetWorkRequest.GetDefault(
        "/api/SalesDeliverySampleProgress/ChiTietNhapKho/${widget.processAID}",
        context,
      );
      final parsedResponse = chiTietKhoHang.ChiTietNhapKhoHangMauModel.fromJson(response);
      lsChiTietKhoHang = parsedResponse.data ?? [];
    } catch (e) {
      debugPrint('Error loading chi tiet kho hang: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lỗi khi tải dữ liệu kho hàng')),
        );
      }
    }
  }

  Future<void> loadData() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      await Future.wait([
        _loadChiTietGiaoHang(),
        _loadChiTietKhoHang(),
      ]);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _refreshData() async {
    await loadData();
  }

  Widget _buildReadOnlyTextField(String label, TextEditingController controller, bool readOnly) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder()
        ),
      ),
    );
  }
}