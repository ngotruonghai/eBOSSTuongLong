import 'package:data_table_2/data_table_2.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';
import 'package:eboss_tuonglong/component/phieugiaohang/NhapYKien_srceen.dart';
import 'package:eboss_tuonglong/helper/calendar/calendar_picker.dart';
import 'package:eboss_tuonglong/provider/tiendoxulymauprovider.dart';
import 'package:eboss_tuonglong/widgets/thongke/chitiettiendoxulymau_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ThongKeTheoDoiXuLyMauSrceen extends StatefulWidget {
  const ThongKeTheoDoiXuLyMauSrceen({super.key});

  @override
  State<ThongKeTheoDoiXuLyMauSrceen> createState() => _ThongKeTheoDoiXuLyMauSrceen();
}

class _ThongKeTheoDoiXuLyMauSrceen extends State<ThongKeTheoDoiXuLyMauSrceen> with SingleTickerProviderStateMixin {
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectFormDate = DateTime.now();
  DateTime _selectToDate = DateTime.now();
  final TextEditingController _processID = TextEditingController();
  final TextEditingController _productID = TextEditingController();
  final TextEditingController _customerAID = TextEditingController();
  final TextEditingController _salesManAID = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectFormDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
    _selectToDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = TienDoXuLyMauProvider();
        provider.LoadDanhSachTienDoXuLyMau(
          context,
          _dateFormat.format(_selectFormDate),
          _dateFormat.format(_selectToDate),
          '',
          '',
          '',
          '',
        );
        return provider;
      },
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: LanguageText(nameId: "tiendoxulymau", defaultValue: "Tiến độ xử lý mẫu"),
            backgroundColor: const Color(0xFF225F59),
          ),
          body: Consumer<TienDoXuLyMauProvider>(
            builder: (context, tiendoxulymauprovider, _) {
              if (tiendoxulymauprovider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (tiendoxulymauprovider.items.isEmpty) {
                return const Center(
                  child: Text("Không có dữ liệu", style: TextStyle(fontSize: 18, color: Colors.grey)),
                );
              }
              return RefreshIndicator(
                onRefresh:
                    () => tiendoxulymauprovider.LoadDanhSachTienDoXuLyMau(
                      context,
                      _dateFormat.format(_selectFormDate),
                      _dateFormat.format(_selectToDate),
                      "",
                      "",
                      "",
                      "",
                    ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: SizedBox(
                      width: 1800,
                      child: DataTable2(
                        showCheckboxColumn: false,
                        // Thêm dòng này để ẩn checkbox
                        fixedTopRows: 1,
                        headingRowColor: WidgetStateProperty.all(const Color(0xFF225F59)),
                        columnSpacing: 8,
                        horizontalMargin: 8,
                        headingTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        columns: [
                          DataColumn2(
                            label: Center(child: Text('${tiendoxulymauprovider.items.length}')),
                            fixedWidth: 50, // hoặc ColumnSize.S nếu muốn dùng size mặc định
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "VoucherID", defaultValue: "Số phiếu"),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "13", defaultValue: "Ngày ghi nhận"),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "masanpham", defaultValue: "Mã sản phẩm"),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "HangerUnitID", defaultValue: "ĐVT Hanger"),
                            size: ColumnSize.S,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "QtyHanger", defaultValue: "SL Hanger"),
                            size: ColumnSize.S,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "TrousersUnitID", defaultValue: "ĐVT Quần"),
                            size: ColumnSize.S,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "TrousersQty", defaultValue: "SL Quần"),
                            size: ColumnSize.S,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "ShirtUnitID", defaultValue: "ĐVT Áo"),
                            size: ColumnSize.S,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "ShirtQty", defaultValue: "SL Áo"),
                            size: ColumnSize.S,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "tenkhachhang", defaultValue: "Tên khách hàng"),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "16", defaultValue: "Nhân viên kinh doanh"),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "CommentsProduct", defaultValue: "Ý kiến đánh giá"),
                            fixedWidth: 200,
                          ),
                          const DataColumn2(label: LanguageText(nameId: "", defaultValue: "..."), size: ColumnSize.S),
                          const DataColumn2(
                            label: LanguageText(nameId: "SewingDate", defaultValue: "Ngày may"),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "FactoryWashDate", defaultValue: "Ngày Wash xưởng"),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "SmartLabDate", defaultValue: "Ngày SmartLab"),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "", defaultValue: "Ngày nhập kho"),
                            size: ColumnSize.L,
                          ),
                        ],
                        rows:
                            tiendoxulymauprovider.items.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item = entry.value;
                              Color? getColorByStatus(int? status) {
                                if (status == 0) return Colors.black;
                                if (status == 1) return Colors.red;
                                if (status == 2) return Colors.green;
                                if (status == 3) return Colors.orange;
                                return null;
                              }

                              return DataRow(
                                onSelectChanged: (selected) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              ChiTietTienDoXuLyMauScreen(processAID: item.processAID ?? '', id: ""),
                                    ),
                                  );
                                },
                                cells: [
                                  DataCell(Center(child: Text('${index + 1}'))), // STT
                                  DataCell(
                                    Text(
                                      item.processID ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: getColorByStatus(item.isColorRed),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item.recordDate.toString().trim(),
                                        style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.productID ?? "".toString().trim(),
                                      style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.unitName ?? '',
                                      style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                    ),
                                  ),
                                  DataCell(
                                    Text(item.qty ?? '', style: TextStyle(color: getColorByStatus(item.isColorRed))),
                                  ),
                                  DataCell(
                                    Text(
                                      item.trouserUnitName ?? '',
                                      style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.trousersQty ?? '',
                                      style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.shirtUnitName ?? '',
                                      style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.shirtQty ?? '',
                                      style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.customerName ?? '',
                                      style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.salesManName ?? '',
                                      style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                    ),
                                  ),
                                  DataCell(
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (context) => AlertDialog(
                                                title: const LanguageText(
                                                  nameId: "CommentsProduct",
                                                  defaultValue: "Ý kiến đánh giá",
                                                ),
                                                content: SingleChildScrollView(
                                                  child: Text(
                                                    item.commentsProduct?.toString() ?? '',
                                                    style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: LanguageText(
                                                      nameId: "dong",
                                                      defaultValue: "Đóng",
                                                      style: TextStyle(fontSize: 13, color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          item.commentsProduct?.toString() ?? '',
                                          // <<< SỬA Ở ĐÂY
                                          style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                          maxLines: 2, // Chỉ hiển thị tối đa 2 dòng
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    GestureDetector(
                                      onTap: () {
                                        final currentItem = item;
                                        showDialog(
                                          context: context,
                                          builder:
                                              (context) => NhapykienSrceen(
                                                ItemAID: "${currentItem.processAID}",
                                                ItemID: "${currentItem.processID}",
                                                Type: "04",
                                              ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.edit_note_outlined,
                                        color: getColorByStatus(item.isColorRed),
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.sewingDate ?? '',
                                      style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.factoryWashDate ?? '',
                                      style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.smartLabDate ?? '',
                                      style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.sampleInnerInDate ?? '',
                                      style: TextStyle(color: getColorByStatus(item.isColorRed)),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          endDrawer: Drawer(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LanguageText(
                      nameId: "VoucherID",
                      defaultValue: "Số phiếu",
                      style: const TextStyle(fontSize: 13, color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    TextField(decoration: const InputDecoration(border: OutlineInputBorder()), controller: _processID),
                    SizedBox(height: 20),
                    const LanguageText(
                      nameId: "masanpham",
                      defaultValue: "Mã sản phẩm",
                      style: const TextStyle(fontSize: 13, color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    TextField(decoration: const InputDecoration(border: OutlineInputBorder()), controller: _productID),
                    SizedBox(height: 20),
                    const LanguageText(
                      nameId: "tenkhachhang",
                      defaultValue: "Tên khách hàng",
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    TextField(
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      controller: _customerAID,
                    ),
                    SizedBox(height: 20),
                    const LanguageText(
                      nameId: "16",
                      defaultValue: "Nhân viên kinh doanh",
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    TextField(
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      controller: _salesManAID,
                    ),
                    const SizedBox(height: 20),
                    const LanguageText(
                      nameId: "34",
                      defaultValue: "Từ ngày",
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    InkWell(
                      onTap: () {
                        _showCalendarFormDatePopup(context);
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(_dateFormat.format(_selectFormDate)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const LanguageText(
                      nameId: "7",
                      defaultValue: "Đến ngày",
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    InkWell(
                      onTap: () {
                        _showCalendarFormDatePopup(context, isToDate: true);
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(_dateFormat.format(_selectToDate)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<TienDoXuLyMauProvider>().LoadDanhSachTienDoXuLyMau(
                          context,
                          _dateFormat.format(_selectFormDate),
                          _dateFormat.format(_selectToDate),
                          _processID.text,
                          _productID.text,
                          _productID.text,
                          _salesManAID.text,
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F615C),
                        foregroundColor: Colors.white,
                      ),
                      child: LanguageText(defaultValue: "Tìm kiếm", nameId: "32"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onDaySelect({required DateTime selectedDay, required DateTime focusedDay, bool isToDay = false}) {
    setState(() {
      isToDay == false ? _selectFormDate = selectedDay : _selectToDate = selectedDay;
    });
    Navigator.pop(context);
  }

  void _showCalendarFormDatePopup(BuildContext context, {bool isToDate = false}) {
    DateTime firstDate = DateTime.utc(2010, 10, 16);
    DateTime lastTime = DateTime.utc(2030, 3, 14);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 1.5,
              height: MediaQuery.of(context).size.height * 0.6,
              child: CalendarPicker(
                firstDay: firstDate,
                lastDay: lastTime,
                focusedDay: isToDate ? _selectToDate : _selectFormDate,
                onDaySelected: (selectedDay, focusedDay) {
                  _onDaySelect(selectedDay: selectedDay, focusedDay: focusedDay, isToDay: isToDate);
                },
              ),
            ),
          ),
    );
  }
}
